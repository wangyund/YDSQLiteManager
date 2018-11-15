//
//  YDTableTemplateConfig.swift
//  YDKit
//
//  Created by 王允顶 on 2018/8/19.
//  Copyright © 2018年 王允顶. All rights reserved.
//

import UIKit

class YDTableTemplateConfig: NSObject, XMLParserDelegate {

    let LABEL_ORM:String = "orm"
    let LABEL_KEY:String = "key"
    let LABEL_ITEM:String = "item"
    let ATTRIBUTE_BEAN_NAME:String = "className"
    let ATTRIBUTE_DAO_NAME:String = "daoName"
    let ATTRIBUTE_TABLE_NAME:String = "tableName"
    let ATTRIBUTE_COLUMN:String = "column"
    let ATTRIBUTE_IDENTITY:String = "identity"
    let ATTRIBUTE_PROPERTY:String = "property"
    let ATTRIBUTE_COLUMN_TYPE:String = "columnType"
    let ATTRIBUTE_TYPE:String = "propertyType"
    
    var parser: XMLParser!
    var orm:YDOrm!
    var ormDic = [String: YDOrm]()
    var key: YDOrmKey!
    var item: YDOrmItem!
    
    static let sharedInstace = YDTableTemplateConfig()
    
    func initXml(_ filePate: String) {
        self.parser = XMLParser(contentsOf: NSURL(fileURLWithPath: filePate) as URL)
        self.parser.delegate = self
        self.parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        switch elementName {
        case LABEL_ORM:
            self.orm = YDOrm()
            self.orm.className = attributeDict[ATTRIBUTE_BEAN_NAME]!
            self.orm.tableName = attributeDict[ATTRIBUTE_TABLE_NAME]!
            self.orm.daoName = attributeDict[ATTRIBUTE_DAO_NAME]!
            let ormKey: String = Bundle.main.infoDictionary![kCFBundleExecutableKey as String] as! String + "." + self.orm.className
            self.ormDic[ormKey] = self.orm

//            self.ormDic["YDSwiftKit." + self.orm.className] = self.orm
            break
        case LABEL_KEY:
            self.key = YDOrmKey()
            self.key.column = attributeDict[ATTRIBUTE_COLUMN]!
            self.key.columnType = attributeDict[ATTRIBUTE_COLUMN_TYPE]!
            self.key.property = attributeDict[ATTRIBUTE_PROPERTY]!
            self.key.propertyType = attributeDict[ATTRIBUTE_TYPE]!
            if(attributeDict[ATTRIBUTE_IDENTITY] == "true") {
                self.key.identity = true
            } else {
                self.key.identity = false
            }
            self.orm.key = self.key
            break
        case LABEL_ITEM:
            self.item = YDOrmItem()
            self.item.column = attributeDict[ATTRIBUTE_COLUMN]!
            self.item.columnType = attributeDict[ATTRIBUTE_COLUMN_TYPE]!
            self.item.property = attributeDict[ATTRIBUTE_PROPERTY]!
            self.item.propertyType = attributeDict[ATTRIBUTE_TYPE]!
            self.orm.items.append(self.item)
            break
        default:
            break
        }
        
    }
}
