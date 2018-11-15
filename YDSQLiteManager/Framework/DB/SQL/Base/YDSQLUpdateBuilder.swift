//
//  YDSQLUpdateBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDSQLUpdateBuilder: YDSQLBuilder {
    func update() -> YDSQLUpdateBuilder {
        self.sql.append("update ")
        return self
    }
    
    override func table(_ table: String) -> YDSQLUpdateBuilder {
        return super.table(table) as! YDSQLUpdateBuilder
    }
    
    func set(colunms: [String: Any]) -> YDSQLUpdateBuilder {
        self.sql.append("set ")
        var index = 0
        for key in colunms.keys {
            self.sql.append(key)
            self.sql.append(" = ")
            appendValue(colunms[key]!)
            index += 1
            if (index < colunms.count) {
                self.sql.append(",")
            }
        }
        self.sql.append(" ")
        return self
    }
    
    func updateTableSetWhere(table: String, columns: [String: Any], name: String, value: Any) -> YDSQLUpdateBuilder {
        return self.update().table(table).set(colunms: columns).wh().whAnd(name, value: value) as! YDSQLUpdateBuilder
    }
}
