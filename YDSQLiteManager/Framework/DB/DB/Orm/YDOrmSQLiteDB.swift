//
//  YDOrmSQLiteDB.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/19.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDOrmSQLiteDB: YDSQLiteDB {

    let createBuilder = YDOrmSQLCreateTableBuilder()
    
    //创建表（根据类+Orm创建对应的变）
    func createTable(cls: Swift.AnyClass) -> Int {
        let sql = createBuilder.createTable(orm: getOrm(cls)).build()
        return Int(execute(sql: sql))
    }
    
    //添加表字段
    //传递cls:目的技术为了找到对应的ORM映射配置
    func alterTableAddColmun(cls: Swift.AnyClass) -> Int {
        let orm = getOrm(cls)
        //1.定义构建查询表字段的SQL语句
        let builder = YDSQLSelectTableBuilder()
        var sql = builder.selectTable(orm.tableName).build()
        //2、构建SQL语句，然后查询字段
        let oldColmuns = query(sql: sql)
        //3、筛选需要原始的字段
        var srcColmuns = [String: String]()
        for item in oldColmuns {
            //获取name字段（获取name这一列）
            let name: String = item["name"] as! String
            //获取type字段（获取type这一列）
            let type: String = item["type"] as! String
            //不是主键就添加
            if name != orm.key?.column {
                srcColmuns[name] = type
            }
        }
        //第二步：构建SQL
        let alterBuilder = YDOrmSQLAlterTableBuilder()
        sql = alterBuilder.alterTable(orm: orm, srcColumns: srcColmuns).build()
        
        //第三步：调用数据库执行SQL
        return Int(execute(sql: sql))
        
    }
    
    func getOrm(_ cls: Swift.AnyClass) -> YDOrm {
        let className = NSStringFromClass(cls)
        return YDTableTemplateConfig.sharedInstace.ormDic[className]!
    }
}
