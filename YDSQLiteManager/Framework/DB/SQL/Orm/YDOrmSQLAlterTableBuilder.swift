//
//  YDOrmSQLAlterTableBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/17.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

//为什么中间定义一个DM_SQLAlterTableBuilder?
//原因：扩张
//ORM（有这样思想：映射）
//案例一：xml文件->model->表(table):映射(ORM-XML方式)
//案例二：json文件->model->表(table):映射(ORM-JSON方式)
//案例三：model映射->model->表(table):映射(ORM-OBJ方式)

//我们当前框架是基于ORM-xml配置文件的方式进行设计的
//假设有一天我改成ORM-OBj方式配置(说白了就是直接通过反射机制动态映射数据库表)，但是同样又一些规范（例如：数据库的表字段和属性字段保持一致）
//就如我们经常看到的FMDB原理实现
//然后这个时候你又要去写一个类吗？重复写基本SQL语句
//所以定义一个SQL语句基类
//总结：所以定义基类的目的就是为了解除耦合,解决基本的SQL语句构建和具体的ORM方案耦合问题
class YDOrmSQLAlterTableBuilder: YDSQLAlterTableBuilder {

    //orm:映射配置
    //srcColumns:原始的字段
    func alterTable(orm: YDOrm, srcColumns: [String: String]) -> YDSQLAlterTableBuilder {
        var columns = [String: String]()
        //过来已存在的字段，添加新的字段
        for item in orm.items {
            let result = srcColumns[item.column]
            if (result == nil) {
                //注意：保存nil不行
                columns[item.column] = item.columnType
            }
        }
        return self.alterTableAddColumnMulti(orm.tableName, columns: columns)
    }
    
}
