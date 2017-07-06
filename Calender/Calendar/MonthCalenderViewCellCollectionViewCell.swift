//
//  MonthCalenderViewCellCollectionViewCell.swift
//  SanhoulouBusiness
//
//  Created by denty on 2017/7/5.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit

struct CalenderExpandIndicator {
    let disableIndex = 998
    
    var expanded:Bool = false
    var expandedIndex:Int = 998
    var selectedIndex:Int = 998
}

class MonthCalenderViewCellCollectionViewCell: UICollectionViewCell {
    
    var collectionView:UICollectionView!
    
    var calenderExpandIndicator = CalenderExpandIndicator()
    
    var taskDateModel:TaskDateModel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCollectionView() -> Void {
        if collectionView == nil
        {
            let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            addSubview(collectionView)
            collectionView.isScrollEnabled = false
            collectionView.register(DayCalenderCell.self, forCellWithReuseIdentifier: "DayCalenderCell")
            collectionView.register(TaskListCell.self, forCellWithReuseIdentifier: "TaskListCell")
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.reloadData()
            collectionView.isPagingEnabled = true
            collectionView.backgroundColor = UIColor.white
            collectionView.snp.makeConstraints { (constraintMaker) in
                constraintMaker.top.equalToSuperview()
                constraintMaker.bottom.equalToSuperview()
                constraintMaker.left.equalToSuperview()
                constraintMaker.right.equalToSuperview()
            }
        }
    }
    
    func loadData(WithModel model:TaskDateModel)
    {
        self.taskDateModel = model
        collectionView.reloadData()
        calenderExpandIndicator = CalenderExpandIndicator()
    }
    
    func expandAction(WithIndexPath indexPath:IndexPath) -> Void {
        var targetIndex = 0
        if indexPath.item < 7
        {
            targetIndex = 7
        }
        else if indexPath.item < 14
        {
            targetIndex = 14
        }
        else if indexPath.item < 21
        {
            targetIndex = 21
        }
        else if indexPath.item < 28
        {
            targetIndex = 28
        }
        else if indexPath.item < 35
        {
            targetIndex = 35
        }
        if self.calenderExpandIndicator.expanded == true
        {
            if self.calenderExpandIndicator.expandedIndex == targetIndex
            {
                if indexPath.item != self.calenderExpandIndicator.selectedIndex
                {
                    self.collectionView.reloadData()
                    self.calenderExpandIndicator.selectedIndex = indexPath.item
                }
                else
                {
                    self.calenderExpandIndicator.selectedIndex = self.calenderExpandIndicator.disableIndex
                    self.calenderExpandIndicator.expanded = false
                    self.calenderExpandIndicator.expandedIndex = 998
                    self.collectionView.performBatchUpdates({[weak self] in
                        guard let `self` = self else { return }
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                        self.collectionView.deleteItems(at: [IndexPath(item: targetIndex, section: 0)])
                    }, completion: {[weak self] (_) in
                        guard let `self` = self else { return }
                        self.collectionView.reloadData()
                    })
                }
            }
            else
            {
                //展开状态再次展开
                self.collectionView.performBatchUpdates({ [weak self] in
                    guard let `self` = self else { return }
                    if let cell:DayCalenderCell = self.collectionView.cellForItem(at: IndexPath(item: self.calenderExpandIndicator.selectedIndex, section: 0)) as? DayCalenderCell
                    {
                        if cell.backgroundColor == UIColor.white
                        {
                            cell.backgroundColor = UIColor.groupTableViewBackground
                            cell.bottomLine.backgroundColor = UIColor.groupTableViewBackground
                        }
                        else
                        {
                            cell.backgroundColor = UIColor.white
                            cell.bottomLine.backgroundColor = UIColor.lightGray
                        }
                    }
                    self.calenderExpandIndicator.selectedIndex = self.calenderExpandIndicator.disableIndex
                    self.calenderExpandIndicator.expanded = false
                    let needCloseIndex = self.calenderExpandIndicator.expandedIndex
                    self.calenderExpandIndicator.expandedIndex = 998
                    self.collectionView.performBatchUpdates({[weak self] in
                        guard let `self` = self else { return }
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionViewScrollPosition.top, animated: true)
                        self.collectionView.deleteItems(at: [IndexPath(item: needCloseIndex, section: 0)])
                        }, completion: nil)
                }, completion: {[weak self] (_) in
                    guard let `self` = self else { return }
                    self.expandAction(WithIndexPath: indexPath)
                })
            }
        }
        else
        {
            self.calenderExpandIndicator.selectedIndex = indexPath.item
            self.calenderExpandIndicator.expanded = true
            self.calenderExpandIndicator.expandedIndex = targetIndex
            self.collectionView.performBatchUpdates({[weak self] in
                guard let `self` = self else { return }
                self.collectionView.insertItems(at: [IndexPath(item: targetIndex, section: 0)])
                }, completion: {[weak self] (_) in
                    guard let `self` = self else { return }
                    self.collectionView.reloadData()
                    self.collectionView.scrollToItem(at: IndexPath(item: targetIndex, section: 0), at: UICollectionViewScrollPosition.centeredVertically, animated: true)
            })
        }
    }
}

extension MonthCalenderViewCellCollectionViewCell:UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.calenderExpandIndicator.expanded == false
        {
            return 35
        }
        else
        {
            return 36
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if self.calenderExpandIndicator.expanded == false
        {
            let cell:DayCalenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCalenderCell", for: indexPath) as! DayCalenderCell
            cell.loadData(withModel: "")
            let cellDate:Date = self.taskDateModel.date.dateFor(.startOfWeek).adjust(.day, offset: indexPath.item)
            cell.backgroundColor = UIColor.white
            if cellDate.toString(style: .month) == self.taskDateModel.date.toString(style: .month)
            {
                cell.dayLabel.textColor = UIColor.darkText
            }
            else
            {
                cell.dayLabel.textColor = UIColor.lightGray
            }
            cell.dayLabel.text = cellDate.toString(style: .ordinalDay).replacingOccurrences(of: "第", with: "")
            return cell
        }
        else
        {
            if self.calenderExpandIndicator.expandedIndex == indexPath.item
            {
                let cell:TaskListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TaskListCell", for: indexPath) as! TaskListCell
                cell.loadData(WithModel: "")
                return cell
            }
            else if self.calenderExpandIndicator.expandedIndex > indexPath.item
            {
                let cell:DayCalenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCalenderCell", for: indexPath) as! DayCalenderCell
                cell.loadData(withModel: "")
                let cellDate:Date = self.taskDateModel.date.dateFor(.startOfWeek).adjust(.day, offset: indexPath.item)
                cell.backgroundColor = UIColor.white
                if cellDate.toString(style: .month) == self.taskDateModel.date.toString(style: .month)
                {
                    cell.dayLabel.textColor = UIColor.darkText
                }
                else
                {
                    cell.dayLabel.textColor = UIColor.lightGray
                }
                cell.dayLabel.text = cellDate.toString(style: .ordinalDay).replacingOccurrences(of: "第", with: "")
                if indexPath.item == calenderExpandIndicator.selectedIndex
                {
                    cell.backgroundColor = UIColor.groupTableViewBackground
                    cell.bottomLine.backgroundColor = UIColor.groupTableViewBackground
                }
                else
                {
                    cell.bottomLine.backgroundColor = UIColor.lightGray
                }
                return cell
            }
            else
            {
                let cell:DayCalenderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCalenderCell", for: indexPath) as! DayCalenderCell
                cell.loadData(withModel: "")
                let cellDate:Date = self.taskDateModel.date.dateFor(.startOfWeek).adjust(.day, offset: indexPath.item-1)
                cell.backgroundColor = UIColor.white
                if cellDate.toString(style: .month) == self.taskDateModel.date.toString(style: .month)
                {
                    cell.dayLabel.textColor = UIColor.darkText
                }
                else
                {
                    cell.dayLabel.textColor = UIColor.lightGray
                }
                cell.dayLabel.text = cellDate.toString(style: .ordinalDay).replacingOccurrences(of: "第", with: "")
                if indexPath.item-1 == calenderExpandIndicator.selectedIndex
                {
                    cell.backgroundColor = UIColor.groupTableViewBackground
                    cell.bottomLine.backgroundColor = UIColor.groupTableViewBackground
                }
                else
                {
                    cell.bottomLine.backgroundColor = UIColor.lightGray
                }
                return cell
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.calenderExpandIndicator.expanded == true && self.calenderExpandIndicator.expandedIndex == indexPath.item
        {
            return CGSize.init(width: self.bounds.width, height: self.bounds.height/3)
        }
        return CGSize.init(width: self.bounds.width/7, height: self.bounds.height/5)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell:DayCalenderCell = self.collectionView.cellForItem(at: indexPath) as? DayCalenderCell
        {
            if cell.backgroundColor == UIColor.white
            {
                cell.backgroundColor = UIColor.groupTableViewBackground
                cell.bottomLine.backgroundColor = UIColor.groupTableViewBackground
            }
            else
            {
                cell.backgroundColor = UIColor.white
                cell.bottomLine.backgroundColor = UIColor.lightGray
            }
        }
        if self.calenderExpandIndicator.expanded == false
        {
            self.expandAction(WithIndexPath: indexPath)
        }
        else
        {
            if self.calenderExpandIndicator.expandedIndex == indexPath.item
            {
                return
            }
            else if self.calenderExpandIndicator.expandedIndex < indexPath.item
            {
                self.expandAction(WithIndexPath: IndexPath(item: indexPath.item-1, section: 0))
            }
            else
            {
                self.expandAction(WithIndexPath: indexPath)
            }
        }
        
    }
}
