//
//  Data+Extensions.swift
//  QuotesApp
//
//  Created by Roman Rakhlin on 2/13/22.
//

import Foundation

// mostly for Notification Service
extension Date {
    
    // returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    // add some minutes to a time
    func withAddedMinutes(minutes: Double) -> Date {
        addingTimeInterval(minutes * 60)
    }
}
