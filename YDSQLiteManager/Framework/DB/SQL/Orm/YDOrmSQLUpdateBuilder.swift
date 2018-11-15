//
//  YDOrmSQLUpdateBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDOrmSQLUpdateBuilder<T: NSObject>: YDSQLUpdateBuilder {
    
    //默认情况下是根据主键更新
    func updateTable(orm: YDOrm, obj: T) -> YDSQLUpdateBuilder {
        //需要更新的字段
        var columns = [String: Any]()
        for item in orm.items {
            let name = item.property
            let value = obj.value(forKey: name)
            columns[item.column] = value
        }
        //查询条件
        let name = orm.key?.column
        let value = obj.value(forKey: (orm.key?.property)!)
        return self.updateTableSetWhere(table: orm.tableName, columns: columns, name: name!, value: value!)
    }

}
