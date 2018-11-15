//
//  YDSQLSelectBuilder.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/16.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

//链式编程
class YDSQLSelectBuilder: YDSQLBuilder {

    /** 查询关键字：select */
    func select() -> YDSQLSelectBuilder {
        self.sql.append("select ")
        return self
    }
    /** 查询所有 */
    func all() -> YDSQLSelectBuilder {
        self.sql.append("* ")
        return self
    }
    func from() -> YDSQLSelectBuilder {
        self.sql.append("from ")
        return self
    }
    
    func selectAllFromTable(table: String) -> YDSQLSelectBuilder {
        return self.select().all().from().table(table) as! YDSQLSelectBuilder
    }
    
    func selectAllFromTable(table: String, name: String, value: Any) -> YDSQLSelectBuilder {
        return self.select().all().from().table(table).wh().whAnd(name, value: value) as! YDSQLSelectBuilder
    }
    
    func selectAllFromTableWhereForma(table: String, wh: [String: Any]) -> YDSQLSelectBuilder {
        return self.select().all().from().table(table).wh().whOrFormat(wh) as! YDSQLSelectBuilder
    }
    
    /** 排序 */
    func orderBy(_ colum: String) -> YDSQLSelectBuilder {
        self.sql.append("order by \(colum) ")
        return self
    }
    //升序
    func orderByAsc() -> YDSQLSelectBuilder {
        self.sql.append("asc ")
        return self
    }
    //降序
    func orderByDesc() -> YDSQLSelectBuilder {
        self.sql.append("desc ")
        return self
    }
    
}
