//
//  YDString-Extension.swift
//  YDSQLiteManager
//
//  Created by rowena on 2018/11/15.
//  Copyright © 2018年 rowena. All rights reserved.
//

import Foundation

extension String {
    
    func sql_positionOf(sub: String) -> Int {
        var pos = -1
        if let range = range(of: sub) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }
    
    func sql_subString(start: Int, length: Int = -1) -> String {
        var len = length
        if len == -1 {
            len = self.count - start
        }
        let st = self.index(startIndex, offsetBy: start)
        let en = self.index(st, offsetBy: len)
        
        let range = st ..< en
        
        return substring(with: range)
        
    }
}
