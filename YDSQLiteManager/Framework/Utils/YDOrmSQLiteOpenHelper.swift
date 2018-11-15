//
//  YDOrmSQLiteOpenHelper.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/19.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDOrmSQLiteOpenHelper: YDSQLiteOpenHelper {

    init() {
        super.init(dbName: "YDOrmSQLite.db", dbVersionCode: 1)
    }
    
    override func onCreate(db: YDOrmSQLiteDB) {
        //创建表
        let result = db.createTable(cls: YDTableInfo.classForCoder())
        print("创建表返回结果：\(result)")
    }
    
    //你没有更新成功，当时版本却更新了？
    //第一种方案：抛异常
    //第二种方案：返回值
    override func onUpdate(db: YDOrmSQLiteDB, oldVersionCode: Int, newVersionCode: Int) -> Int {
        //调用更新数据库表字段
        if newVersionCode == 1 {
            //更新一个字段（t_user_sex）
            let result = db.alterTableAddColmun(cls: YDTableInfo.classForCoder())
            print("添加数据库表字段结果：\(result)")
            return result
        }
        return 0
    }
    
}
