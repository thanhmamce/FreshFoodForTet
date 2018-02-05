//
//  DateExtension.swift
//  LEORI
//
//  Created by Gadapxichlo on 3/13/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

extension Date {
    func toString(withFormat format: String) -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        return dateFormatter.string(from: self)
    }
    
    func dateDifferenceString() -> String {
        let now = Date()
        let diff = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: now)
        
        let years = diff.year ?? 0
        if years > 0 {
            return "\(years)y ago"
        }
        
        let months = diff.month ?? 0
        if months > 0 {
            return "\(months)m ago"
        }
        
        let days = diff.day ?? 0
        if days > 0 {
            return "\(days)d ago"
        }
        
        let hours = diff.hour ?? 0
        if hours > 0 {
            return "\(hours)h ago"
        }
        
        let minutes = diff.minute ?? 0
        if minutes > 0 {
            return "\(minutes)m ago"
        }
        
        let seconds = diff.minute ?? 0
        if seconds > 0 {
            return "\(seconds)s ago"
        }
        
        return "Now"
    }
}
