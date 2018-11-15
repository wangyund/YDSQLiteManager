//
//  YDOrmSQLCreateTableBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/15.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDOrmSQLCreateTableBuilder: YDSQLCreateTableBuilder {
    
    //orm -> 表 -> 类
    func createTable(orm: YDOrm) -> YDSQLCreateTableBuilder {
        var columns = [String: String]()
        //添加字段
        //首先添加主键
        columns[(orm.key?.column)!] = self.getColumnType(propertyType: (orm.key?.property)!)
        //其次添加普通属性
        for item in orm.items {
            columns[item.column] = self.getColumnType(propertyType: (item.propertyType))
        }
        return self.create().table(orm.tableName).columns(columns)
    }
}
