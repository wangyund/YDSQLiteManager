//
//  YDBaseDao.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDBaseDao<T: NSObject>: NSObject {

    private var helper: YDOrmSQLiteOpenHelper?
    private let insertBuilder = YDOrmSQLInsertBuilder<T>()
    private let deleteBuilder = YDOrmSQLDeleteBuilder<T>()
    private let selectBuilder = YDOrmSQLSelectBuilder<T>()
    private let updateBuilder = YDOrmSQLUpdateBuilder<T>()
    
    init(helper: YDOrmSQLiteOpenHelper) {
        super.init()
        self.helper = helper
    }
    
    override init() {
        super.init()
    }
    
    //插入数据
    func insert(obj: T) -> Int {
        let orm = getOrm(cls: T.classForCoder())
        //根据ORM构建SQL语句
        let sql = insertBuilder.insertIntoTableOrm(orm: orm, obj: obj).build()
        
        return Int((self.helper?.getDb().execute(sql: sql))!)
    }
    
    //更新用户信息
    func update(obj: T) -> Int {
        let orm = getOrm(cls: obj.classForCoder)
        let sql = updateBuilder.updateTable(orm: orm, obj: obj).build()
        
        return Int((self.helper?.getDb().execute(sql: sql))!)
    }
    
    //删除指定用户
    func delete(obj: T) -> Int {
        //构建SQL
        let orm = getOrm(cls: obj.classForCoder)
        let sql = deleteBuilder.deleteFromTable(orm: orm, obj: obj).build()
        return Int((self.helper?.getDb().execute(sql: sql))!)
    }
    
    //根据条件查询（让客户端指定查询条件）
    func select(wh: [String: Any]) -> Array<T> {
        let orm = getOrm(cls: T.classForCoder())
        let sql = selectBuilder.selectAllTable(orm: orm, wh: wh).build()
        return self.select(orm: orm, sql: sql)
    }
    
    //查询所有用户
    func selectAll() -> Array<T> {
        let orm = getOrm(cls: T.classForCoder())
        let sql = selectBuilder.selectAllTable(orm: orm).build()
        return self.select(orm: orm, sql: sql)
    }
    
    //查询单个用户（根据主键查询）
    func select(id: Int) -> T {
        let orm = getOrm(cls: T.classForCoder())
        let sql = selectBuilder.selectAllTable(orm: orm, id: id).build()
        return self.select(orm: orm, sql: sql)[0]
    }
    
    private func select(orm: YDOrm, sql: String) -> Array<T> {
        let dicArray: [[String: Any]] = (self.helper?.getDb().query(sql: sql))!
        var obj: T? = nil
        var array = Array<T>()
        for item in dicArray {
            //创建对象
            obj = T()
            //首先获取主键
            var value = item[(orm.key?.column)!]
            //通过KVC赋值
            obj?.setValue(value, forKey: (orm.key?.property)!)
            //接下来获取普通字段
            for ormItem in orm.items {
                value = item[ormItem.column]
                obj?.setValue(value, forKey: ormItem.property)
            }
            array.append(obj!)
        }
        return array
    }
    
    /**
     * 根据对象名获取类名
     *
     * @return 返回结构：项目名称.类名
     */
    func getOrm(cls: Swift.AnyClass) -> YDOrm {
        //返回结构：项目名称.k类名
        let className = NSStringFromClass(cls)
        let orm = YDTableTemplateConfig.sharedInstace.ormDic[className]
        return orm!
    }
}
