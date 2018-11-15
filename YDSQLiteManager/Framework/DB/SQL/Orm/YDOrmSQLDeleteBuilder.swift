//
//  YDOrmSQLDeleteBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/12.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDOrmSQLDeleteBuilder<T: NSObject>: YDSQLDeleteBuilder {
    
    //传入ORM映射配置
    //传入具体的对象
    func deleteFromTable(orm: YDOrm, obj: T) -> YDSQLDeleteBuilder {
        //删除操作?
        //思考：根据什么条件删除？
        //可以固定这个条件，或者自定义条件
        //根据主键删除
        //第一步：获取主键值(KVC获取)
        //如果你采用KVC需要注意：对象属性必须有默认值
        //方案一：反射机制
        //方案二：KVC也可以
        //方案三：Runtime也可以
        let value = obj.value(forKey: (orm.key?.property)!)
        
        return self.deleteFromTable(orm.tableName, whName: (orm.key?.column)!, whValue: value!)
        
    }

}
