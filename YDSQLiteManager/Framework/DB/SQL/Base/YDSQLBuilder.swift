//
//  YDSQLBuilder.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/16.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDSQLBuilder: NSObject {

    //全局SQL语句
    var sql: String = ""
    
    /** 表名:由外部控制 */
    func table(_ table: String) -> YDSQLBuilder {
        self.sql.append("\(table) ")
        return self
    }
    /** 插入 */
    //插入的字段
    func colums(_ colums: Array<String>) -> YDSQLBuilder {
        //拼接字段
        var index = 0
        for colum in colums {
            self.sql.append(colum)
            index += 1
            if index < colums.count {
                self.sql.append(",")
            }
        }
        self.sql.append(" ")
        
        return self
    }
    //专门针对值
    func values(_ values: Array<Any>) -> YDSQLBuilder {
        var index = 0
        for value in values {
            self.appendValue(value)
            index += 1
            if index < values.count {
                self.sql.append(",")
            }
        }
        self.sql.append(" ")
        return self
    }
    //处理类型
    func appendValue(_ value: Any) {
        switch value {
        case let someInt as Int:
            self.sql.append("\(someInt)")
            break
        case let someFloat as Float:
            self.sql.append("\(someFloat)")
            break
        case let someDouble as Double:
            self.sql.append("\(someDouble)")
            break
        case let someSrring as String:
            self.sql.append("'")
            self.sql.append(someSrring)
            self.sql.append("'")
        default:
            break
        }
    }
    /** 条件：wh */
    func wh() -> YDSQLBuilder {
        self.sql.append("where ")
        return self
    }
    func whAnd(_ wh: [String: Any]) -> YDSQLBuilder {
        return self.wh(isFormat: false, isAnd: true, isOr: false, wh)
    }
    func whAnd(_ name: String, value: Any) -> YDSQLBuilder {
        var wh = [String: Any]()
        wh[name] = value
        return self.wh(isFormat: false, isAnd: true, isOr: false, wh)
    }
    func whAndFormat(_ wh: [String: Any]) -> YDSQLBuilder {
        return self.wh(isFormat: true, isAnd: true, isOr: false, wh)
    }
    func whOr(_ wh: [String: Any]) -> YDSQLBuilder {
        return self.wh(isFormat: false, isAnd: false, isOr: true, wh)
    }
    func whOrFormat(_ wh: [String: Any]) -> YDSQLBuilder {
        return self.wh(isFormat: true, isAnd: false, isOr: true, wh)
    }
    func wh(isFormat: Bool, isAnd: Bool, isOr: Bool, _ wh: [String: Any]) -> YDSQLBuilder {
        var index = 0
        for key in wh.keys {
            self.sql.append(key)
            self.sql.append(" = ")
            if isFormat {
                self.sql.append("? ")
            } else {
                self.appendValue(wh[key]!)
            }
            index += 1
            if index < wh.count {
                if isAnd {
                    self.sql.append(" and ")
                }
                if isOr {
                    self.sql.append(" or ")
                }
            }
        }
        
        return self
    }
    
    func build() -> String {
        self.sql.append(";")
        return self.sql;
    }
    
    
}
