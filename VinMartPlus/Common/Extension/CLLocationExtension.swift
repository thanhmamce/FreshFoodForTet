//
//  CLLocationExtension.swift
//  Taxi Dispatching
//
//  Created by Nguyen Van Hai on 3/12/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocation {
    func toString() -> String? {
        return String(format: "LG:%@_LT:%@", NSNumber(value: self.coordinate.longitude).stringValue, NSNumber(value: self.coordinate.latitude).stringValue)
    }
    
    class func fromString(_ str: String?) -> CLLocation? {
        guard let str = str else {
            return nil
        }
        
        let components = str.components(separatedBy: "_")
        if components.count < 2 {
            return nil
        }
        
        let longitude = components[0].components(separatedBy: ":").last?.doubleValue ?? 0
        let latitude = components[1].components(separatedBy: ":").last?.doubleValue ?? 0
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
