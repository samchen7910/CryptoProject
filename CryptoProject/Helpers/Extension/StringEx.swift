//
//  StringEx.swift
//  CryptoProject
//
//  Created by Tran Gia Huy on 3/18/18.
//  Copyright © 2018 HUDU. All rights reserved.
//

import Foundation

extension String {
    
    func toDate(format: String? = nil) -> Date? {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd:HH:mm:ss"
        let date = dateFormatter.date(from: self) ?? nil
        return date
    }
    
    func isStringAnInt() -> Bool {
            
        if let _ = Int(self) {
            return true
        }
        return false
    }
    
}
