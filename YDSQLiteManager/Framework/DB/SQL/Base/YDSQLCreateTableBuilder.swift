//
//  YDSQLCreateTableBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/15.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDSQLCreateTableBuilder: YDSQLBuilder {

    func create() -> YDSQLCreateTableBuilder {
        self.sql.append("create ")
        return self
    }
    
    override func table(_ table: String) -> YDSQLCreateTableBuilder {
        self.sql.append("table IF NOT EXISTS ")
        return super.table(table) as! YDSQLCreateTableBuilder
    }
    
    //Int类型字段
    func columnInt(_ column: String) -> YDSQLCreateTableBuilder {
        return self.column(column, type: "integer")
    }
    
    //浮点型的字段
    func columnReal(_ column: String) -> YDSQLCreateTableBuilder {
        return self.column(column, type: "real")
    }
    
    //string类型的字段
    func columnString(_ column: String) -> YDSQLCreateTableBuilder {
        return self.column(column, type: "text")
    }
    
    func column(_ column: String, type: String) -> YDSQLCreateTableBuilder {
        self.sql.append(column)
        self.sql.append(" \(type) ")
        return self
    }
    
    func comma() -> YDSQLCreateTableBuilder {
        self.sql.append(",")
        return self
    }
    
    //多个字段
    //key：b表示字段类型
    func columns(_ columns:[String: String]) -> YDSQLCreateTableBuilder {
        self.sql.append("(")
        var builder = self
        var index = 0
        for item in columns {
            builder = self.column(item.key, type: item.value)
            index += 1
            if index < columns.count {
                builder = self.comma()
            }
        }
        self.sql.append(")")
        return builder
    }
    
    //是否是主键
    func primaryKey() -> YDSQLCreateTableBuilder {
        self.sql.append("primary key ")
        return self
    }
    
    //指定字段不能为空
    func notNull() -> YDSQLCreateTableBuilder {
        self.sql.append("not null ")
        return self
    }
    
    //默认值拼接
    func defValue(_ def: Any) -> YDSQLCreateTableBuilder {
        self.sql.append("default ")
        self.appendValue(def)
        return self
    }
    
    //根据属性类型获取字段的类型
    func getColumnType(propertyType: String) -> String {
        if propertyType == "Int" {
            return "integer"
        }
        if propertyType == "String" {
            return "text"
        }
        return ""
    }
    
}
