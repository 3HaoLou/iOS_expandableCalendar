//
//  TaskListCell.swift
//  SanhoulouBusiness
//
//  Created by denty on 2017/7/6.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit

class TaskListCell: UICollectionViewCell {
    
    var rightLine:UIView!
    var bottomLine:UIView!
    
    func loadData(WithModel model:Any) -> Void {
        self.backgroundColor = UIColor.groupTableViewBackground
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
