//
//  UserDefaults+Extension.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 09.01.2022.
//

import Foundation

// for Notifcations screen
extension UserDefaults {
    
    func set(date: Date?, forKey key: String){
        self.set(date, forKey: key)
    }
    
    func date(forKey key: String) -> Date? {
        return self.value(forKey: key) as? Date
    }
}
