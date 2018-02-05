//
//  IntExtensions.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/21/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation
struct DurationModel {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(hours: Int, minutes: Int, seconds: Int) {
        guard hours >= 0, minutes >= 0, seconds >= 0 else {
            self.hours = 0
            self.minutes = 0
            self.seconds = 0
            return
        }
        
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    init(duration: Int) {
        guard duration >= 0 else {
            self.hours = 0
            self.minutes = 0
            self.seconds = 0
            return
        }
        
        self.hours = duration / 3600
        self.minutes = (duration % 3600) / 60
        self.seconds = (duration % 3600) % 60
    }
    
    var hoursString: String {
        return "\(self.hours)"
    }
    
    var minutesString: String {
        return "\(self.minutes)"
    }
    
    var secondsString: String {
        return "\(self.seconds)"
    }
    
    var durationFormat: String {
        if self.hours > 0 {
            return hoursString + "h"
                + " "
                + minutesString + "m"
        } else {
            return minutesString + "m"
                + " "
                + secondsString + "s"
        }
    }
    
    var timeFormat: String {
        return String(format: "%02d:%02d:%02d", self.hours, self.minutes, self.seconds)
    }
    
    var hoursFormat: String {
        return String(format: "%02d", self.hours)
    }
    
    var minutesFormat: String {
        return String(format: "%02d", self.minutes)
    }
    
    var secondsFormat: String {
        return String(format: "%02d", self.seconds)
    }
    
}

extension Int {
    
    var durationObjectModel: DurationModel {
        return DurationModel(duration: self)
    }
    
    func thousandSeparatorFormat() -> String? {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        
        return formatter.string(from: NSNumber(value: self as Int))
    }
    
}
