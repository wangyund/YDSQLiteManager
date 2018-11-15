//
//  YDOrmSQLSelectBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDOrmSQLSelectBuilder<T: NSObject>: YDSQLSelectBuilder {

    //查询所有数据
    func selectAllTable(orm: YDOrm) -> YDSQLSelectBuilder {
        return self.selectAllFromTable(table: orm.tableName)
    }
    
    //根据条件查询（根据主键）
    func selectAllTable(orm: YDOrm, id: Int) -> YDSQLSelectBuilder {
        return self.selectAllFromTable(table: orm.tableName, name: (orm.key?.column)!, value: id)
    }
    
    //根据其他的条件查询
    func selectAllTable(orm: YDOrm, wh: [String: Any]) -> YDSQLSelectBuilder {
        return self.selectAllFromTable(table: orm.tableName).wh().whOr(wh) as! YDSQLSelectBuilder
    }
}
