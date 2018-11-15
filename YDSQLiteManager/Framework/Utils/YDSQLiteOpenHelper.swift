//
//  YDSQLiteOpenHelper.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/19.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

//更好的统一管理数据库操作(例如：表创建、删除表、更新表字段等等......)
class YDSQLiteOpenHelper: NSObject {

    //默认数据库表名
    private var dbName: String = "YDOrmSQLite.db"
    //数据库版本号
    //数据库的版本号(例如：版本号发生更新，那么框架就会自定更新数据库表字段)
    //什么是更新（或者说升级），说白了就是你要修改、新增、删除等等....数据库中的表字段操作
    private var dbVersionCode: Int = 1
    
    private var db: YDOrmSQLiteDB?
    
    init(dbName: String, dbVersionCode: Int) {
        super.init()
        self.dbName = dbName
        self.dbVersionCode = dbVersionCode
        self.db = YDOrmSQLiteDB(dbName: dbName)
        //版本号需要保持（保存到本地）
        let userDefault = UserDefaults.standard
        let newVersionCode = userDefault.object(forKey: "YDDBVersionCode")
        if newVersionCode == nil {
            //第一次创建数据库
            self.onCreate(db: self.db!)
        } else {
            let versionVode = newVersionCode as! Int
            //多次了(更新数据库)
            if (self.dbVersionCode != versionVode) {
                let result = self.onUpdate(db: self.db!, oldVersionCode: versionVode, newVersionCode: self.dbVersionCode)
                if (result == 1) {
                    userDefault.set(self.dbVersionCode, forKey: "YDDBVersionCode")
                }
            }
        }
    }
    
    //创建表
    func onCreate(db: YDOrmSQLiteDB) {
        
    }
    
    //更新表
    func onUpdate(db: YDOrmSQLiteDB, oldVersionCode: Int, newVersionCode: Int) -> Int {
        return 0
    }
 
    func getDb() -> YDOrmSQLiteDB {
        return self.db!
    }
}
