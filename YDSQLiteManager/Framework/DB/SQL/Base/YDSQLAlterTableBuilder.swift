//
//  YDSQLAlterTableBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/17.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDSQLAlterTableBuilder: YDSQLBuilder {

    func alter() -> YDSQLAlterTableBuilder {
        self.sql.append("alter ")
        return self;
    }
    
    override func table(_ table: String) -> YDSQLAlterTableBuilder {
        self.sql.append("table ")
        return super.table(table) as! YDSQLAlterTableBuilder
    }
    
    func add() -> YDSQLAlterTableBuilder {
        self.sql.append("add column ")
        return self;
    }
    
    func rename() -> YDSQLAlterTableBuilder {
        self.sql.append("rename column ")
        return self
    }
    
    //更新字段（key:value方式保存）
    //key:字段名称   value:字段类型
    //提供两个方法:一个是添加单个字段，一个添加多个字段
    //添加一个字段
    func column(name: String, type: String) -> YDSQLAlterTableBuilder {
        self.sql.append("\(name) \(type) ")
        return self
    }
    
    //添加多个字段
    func columnMulti(_ columns: [String: String]) -> YDSQLAlterTableBuilder {
        var builder = self
        var index = 0
        for item in columns {
            builder = self.column(name: item.key, type: item.value)
            index += 1
            if index < columns.count {
                self.sql.append(", ")
            }
        }
        return builder
    }
    
    //一共一个构建SQL语句的方法（单个字段）
    func alterTableAddColumn(_ table: String, name: String, type: String) -> YDSQLAlterTableBuilder {
        return self.alter().table(table).add().column(name: name, type: type)
    }
    
    //提供一个构建SQL语句方法（多个字段）
    func alterTableAddColumnMulti(_ table: String, columns: [String: String]) -> YDSQLAlterTableBuilder {
        return self.alter().table(table).add().columnMulti(columns)
    }
}
