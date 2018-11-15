//
//  YDSQLSelectTableBuilder.swift
//  YDAppleKit
//
//  Created by rowena on 2018/10/16.
//  Copyright © 2018年 wuyezhiguhun. All rights reserved.
//

import UIKit

class YDSQLSelectTableBuilder: YDSQLBuilder {

    func pragma() -> YDSQLSelectTableBuilder {
        self.sql.append("PRAGMA ")
        return self
    }
    
    override func table(_ table: String) -> YDSQLSelectTableBuilder {
        self.sql.append("table_info([\(table)])")
        return self
    }
    
    func selectTable(_ table: String) -> YDSQLSelectTableBuilder {
        return self.pragma().table(table)
    }
    
}
