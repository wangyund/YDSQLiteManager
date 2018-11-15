//
//  YDOrm.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/19.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDOrm: NSObject {

    var tableName:String = ""
    var className:String = ""
    var daoName:String = ""
    
    var key:YDOrmKey?
    var items:Array<YDOrmItem> = Array<YDOrmItem>()
    
}
