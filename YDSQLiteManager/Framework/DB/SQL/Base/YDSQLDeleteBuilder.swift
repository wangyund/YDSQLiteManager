//
//  YDSQLDeleteBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

//删除操作
class YDSQLDeleteBuilder: YDSQLBuilder {
    
    func delete() -> YDSQLDeleteBuilder {
        self.sql.append("delete ")
        return self
    }
    
    func from() -> YDSQLDeleteBuilder {
        self.sql.append("from ")
        return self
    }
    
    override func table(_ table: String) -> YDSQLDeleteBuilder {
        return super.table(table) as! YDSQLDeleteBuilder
    }
    
    //提供一个构建的SQL方法
    func deleteFromTable(_ table: String, wh: [String: Any]) -> YDSQLDeleteBuilder {
        return self.delete().from().table(table).wh().whOrFormat(wh) as! YDSQLDeleteBuilder
    }
    
    func deleteFromTable(_ table: String, whName: String, whValue: Any) -> YDSQLDeleteBuilder {
        return self.delete().from().table(table).wh().whAnd(whName, value: whValue) as! YDSQLDeleteBuilder
    }
}
