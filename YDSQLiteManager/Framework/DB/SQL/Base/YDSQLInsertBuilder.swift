//
//  YDSQLInsertBuilder.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/16.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDSQLInsertBuilder: YDSQLBuilder {

    func insert() -> YDSQLInsertBuilder {
        self.sql.append("insert ")
        return self
    }
    func into() -> YDSQLInsertBuilder {
        self.sql.append("into ")
        return self
    }
    override func table(_ table: String) -> YDSQLInsertBuilder {
        return super.table(table) as! YDSQLInsertBuilder
    }
    //插入的字段
    override func colums(_ colums: Array<String>) -> YDSQLInsertBuilder {
        self.sql.append("(")
        let builder = super.colums(colums)
        self.sql.append(") ")
        return builder as! YDSQLInsertBuilder
    }
    //values关键字
    func values() -> YDSQLInsertBuilder {
        self.sql.append("values ")
        return self
    }
    //插入一行数据
    //实现首行插入一行数据
    override func values(_ values: Array<Any>) -> YDSQLInsertBuilder {
        var builder = self.values()
        self.sql.append("(")
        builder = super.values(values) as! YDSQLInsertBuilder
        self.sql.append(") ")
        return builder
    }
    //批量插入
    func batchValues(_ values: Array<Array<Any>>) -> YDSQLInsertBuilder {
        var builder = self.values()
        var index = 0
        for value in values {
            self.sql.append("(")
            builder = super.values(value) as! YDSQLInsertBuilder
            self.sql.append(") ")
            index += 1
            if index < values.count {
                self.sql.append(",")
            }
        }
        return builder
    }
}

