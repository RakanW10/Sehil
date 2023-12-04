//
//  FormatHelpers.swift
//  Sehil
//
//  Created by Rakan Alotaibi on 19/05/1445 AH.
//

import Foundation
struct FormatHelpers{
    static func calculateTimeDifference(from date: Date) -> String {
        let currentDate = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.minute, .hour, .day], from: date, to: currentDate)
        
        if let days = components.day, days > 0 {
            return "\(days) d"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours) h"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) m"
        } else {
            return "now"
        }
    }
}
