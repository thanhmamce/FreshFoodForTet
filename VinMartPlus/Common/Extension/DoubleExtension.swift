//
//  DoubleExtension.swift
//  SamsungConnectAuto
//
//  Created by Trinh Tuan Linh on 8/30/16.
//  Copyright © 2017 Samsung Electronics Co., Ltd. All rights reserved. All rights reserved.
//

import Foundation

extension Double {
    
    func format(_ f: Int) -> String {
        
        let defaultString = String(format: "%.\(f)f", self)
        
        guard f > 0 else {
            return defaultString
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.roundingMode = .halfUp
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = f
        
        let formattedString = formatter.string(from:  NSNumber(value: self))
        return formattedString?.replacingOccurrences(of: ",", with: "") ?? defaultString
    }
}
