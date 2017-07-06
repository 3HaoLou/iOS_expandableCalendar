//
//  SwiftUtils.swift
//  Calender
//
//  Created by denty on 2017/7/6.
//  Copyright © 2017年 broydenty. All rights reserved.
//

import UIKit

class SwiftUtils: NSObject {

    class func timeFormat() ->DateFormatter
    {
        let calendar = Calendar.current
        let formatter:DateFormatter = DateFormatter()
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = calendar.timeZone
        formatter.locale = calendar.locale
        return formatter
    }
    
}
