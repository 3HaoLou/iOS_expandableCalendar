//
//  ViewController.swift
//  Calender
//
//  Created by denty on 2017/7/6.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: 日历
    var calender:ExpandCalender!

    // MARK: - **************【 xib 】**************
    @IBOutlet weak var titleLabel: UILabel!
    
    
    // MARK: - **************【 方法实现 】**************
    // MARK: 生命周期相关
    override func viewDidLoad() {
        super.viewDidLoad()
        calender = ExpandCalender.init(withframe: CGRect.init(x: 0,
                                                              y: 0,
                                                              width: UIScreen.main.bounds.width,
                                                              height: UIScreen.main.bounds.height - (25+64)),
                                       startDateString: "2015 1 1",
                                       endDateString: "2018 1 1",
                                       willMonthChange: {[weak self] (month) in
                                        guard let `self` = self else { return }
                                        self.titleLabel.text = month
        })
        
        self.view.addSubview(calender)
        calender.snp.makeConstraints { (constraintMaker) in
            constraintMaker.top.equalToSuperview().offset(25+64)
            constraintMaker.left.equalToSuperview()
            constraintMaker.right.equalToSuperview()
            constraintMaker.bottom.equalToSuperview()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

