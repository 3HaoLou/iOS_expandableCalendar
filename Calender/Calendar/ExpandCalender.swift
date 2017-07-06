//
//  ExpandCalender.swift
//  SanhoulouBusiness
//
//  Created by denty on 2017/7/5.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit
//import AFDateHelper

class ExpandCalender: UIView {
    
    typealias WillMonthChange = (String) ->Void
    // MARK: - **************【 回调 】**************
    var willMonthChange:WillMonthChange!
    // MARK: - **************【 逻辑变量 】**************
    var startDate:Date = Date()
    var endDate:Date = Date()
    var monthCount:Int = 0
    // MARK: - **************【 xib 】**************
    fileprivate var collectionView:UICollectionView!
    
    // MARK: - **************【 方法实现 】**************
    // MARK: 生命周期相关
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(withframe:CGRect, startDateString:String = "2013 1 1", endDateString:String = "2020 1 1", willMonthChange:WillMonthChange? = nil){
        self.init()
        self.frame = withframe
        if let monthBlock:WillMonthChange = willMonthChange
        {
            self.willMonthChange = monthBlock
        }
        self.startDate = SwiftUtils.timeFormat().date(from: startDateString)!
        self.endDate = SwiftUtils.timeFormat().date(from: endDateString)!
        self.monthCount = Int(endDate.since(startDate, in: .month))
        self.makeCollectionView(Withbounds: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCollectionView(Withbounds bounds:CGRect) -> Void {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: bounds, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        addSubview(collectionView)
        collectionView.register(MonthCalenderViewCellCollectionViewCell.self, forCellWithReuseIdentifier: "MonthCalenderViewCellCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = UIColor.white
        collectionView.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
            constraintMaker.left.equalToSuperview()
            constraintMaker.right.equalToSuperview()
        }
        self.orientationCurrentDate()
    }
    
    func orientationCurrentDate() -> Void {
        if Date() > self.startDate && Date() < self.endDate{
            let distanceMonthCount = Int(Date().since(startDate, in: .month))
            let rect = self.collectionView.layoutAttributesForItem(at: IndexPath(row: distanceMonthCount-1, section: 0))?.frame
            collectionView.contentOffset = (rect?.origin)!
            let index = distanceMonthCount-1
            let monthData = self.startDate.adjust(DateComponentType.month, offset: index)
            var monthString = ""
            if monthData.compare(DateComparisonType.isThisYear)
            {
                monthString = monthData.toString(style: DateStyleType.month)
            }
            else
            {
                monthString = monthData.toString(format: DateFormatType.isoYearMonth).replacingOccurrences(of: "-", with: "年") + "月"
            }
            self.willMonthChange(monthString)
        }
    }
}

extension ExpandCalender:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return monthCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell:MonthCalenderViewCellCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthCalenderViewCellCollectionViewCell", for: indexPath) as! MonthCalenderViewCellCollectionViewCell
        cell.makeCollectionView()
        let taskDate:TaskDateModel = TaskDateModel()
        taskDate.date = self.startDate.adjust(DateComponentType.month, offset: indexPath.row)
        cell.loadData(WithModel: taskDate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: self.bounds.width, height: self.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = collectionView.indexPathsForVisibleItems.last!.item
        let monthData = self.startDate.adjust(DateComponentType.month, offset: index)
        var monthString = ""
        if monthData.compare(DateComparisonType.isThisYear)
        {
            monthString = monthData.toString(style: DateStyleType.month)
        }
        else
        {
            monthString = monthData.toString(format: DateFormatType.isoYearMonth).replacingOccurrences(of: "-", with: "年") + "月"
        }
        self.willMonthChange(monthString)
    }
}
