//
//  DayCalenderCell.swift
//  SanhoulouBusiness
//
//  Created by denty on 2017/7/5.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit

class DayCalenderCell: UICollectionViewCell {
    var dayLabel:UILabel!
    var tipLabelList:[UILabel]! = []
    
    var rightLine:UIView!
    var bottomLine:UIView!
    
    
    func loadData(withModel model:Any) -> Void {
        if dayLabel == nil
        {
            dayLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
            dayLabel.font = UIFont.systemFont(ofSize: 12)
            dayLabel.textAlignment = .center
            addSubview(dayLabel)
            dayLabel.snp.makeConstraints({ (constraintMaker) in
                constraintMaker.left.equalToSuperview()
                constraintMaker.top.equalToSuperview()
                constraintMaker.height.equalTo(30)
                constraintMaker.width.equalTo(40)
            })
        }
        if tipLabelList.count == 0
        {
            for index:Int in 0...2
            {
                let distance:CGFloat = CGFloat(index)*(self.bounds.height/3*2/3)
                let tipLabel:UILabel = UILabel(frame: CGRect(x: 0, y: self.bounds.height/3*2+distance, width: self.bounds.width, height: self.bounds.height/3*2/3))
                tipLabelList.append(tipLabel)
            }
        }
        if rightLine == nil
        {
            rightLine = UIView()
            rightLine.backgroundColor = UIColor.lightGray
            bottomLine = UIView()
            bottomLine.backgroundColor = UIColor.lightGray
            addSubview(rightLine)
            addSubview(bottomLine)
            bottomLine.snp.makeConstraints({ (constraintMaker) in
                constraintMaker.left.equalToSuperview()
                constraintMaker.right.equalToSuperview()
                constraintMaker.bottom.equalToSuperview()
                constraintMaker.height.equalTo(0.5)
            })
            rightLine.snp.makeConstraints({ (constraintMaker) in
                constraintMaker.top.equalToSuperview()
                constraintMaker.right.equalToSuperview()
                constraintMaker.bottom.equalToSuperview()
                constraintMaker.width.equalTo(0.5)
            })
        }
    }
}
