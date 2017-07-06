//
//  CalenderTaskCell.swift
//  SanhoulouBusiness
//
//  Created by denty on 2017/7/6.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit
//import SnapKit

class CalenderTaskCell: UICollectionViewCell {
    
    var tableView:UITableView!
    
    func loadData(withModel model:Any) -> Void {
        if tableView == nil
        {
            tableView = UITableView.init(frame: self.bounds, style: UITableViewStyle.plain)
            self.addSubview(tableView)
            tableView.snp.makeConstraints({ (constraintMaker) in
                constraintMaker.margins.equalToSuperview()
            })
        }
    }

}
