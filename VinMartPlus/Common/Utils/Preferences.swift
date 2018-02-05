//
//  Preferences.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/18/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

public enum PreferenceKey: String {
    
    // Push Service
    case pushPermissionEnabled          = "pushPermissionEnabled"
    case pushServiceEnabled             = "pushServiceEnabled"
}

class Preferences {
    
    // MARK: Getter
    class func getBoolean(keyValue: PreferenceKey) -> Bool? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? Bool else {
            return nil
        }
        
        return value
    }
    
    class func getInt(keyValue: PreferenceKey) -> Int? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? Int else {
            return nil
        }
        
        return value
    }
    
    class func getInt64(keyValue: PreferenceKey) -> Int64? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? Int64 else {
            return nil
        }
        
        return value
    }
    
    class func getDouble(keyValue: PreferenceKey) -> Double? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? Double else {
            return nil
        }
        
        return value
    }
    
    class func getFloat(keyValue: PreferenceKey) -> Float? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? Float else {
            return nil
        }
        
        return value
    }
    
    class func getString(keyValue: PreferenceKey) -> String? {
        guard let value = UserDefaults.standard.object(forKey: keyValue.rawValue) as? String else {
            return nil
        }
        
        return value
    }
    
    // MARK: Setter
    class func putBoolean(keyValue: PreferenceKey, value: Bool) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    class func putInt(keyValue: PreferenceKey, value: Int) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    class func putInt64(keyValue: PreferenceKey, value: Int64) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    class func putDouble(keyValue: PreferenceKey, value: Double) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    class func putFloat(keyValue: PreferenceKey, value: Float) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    class func putString(keyValue: PreferenceKey, value: String) {
        UserDefaults.standard.set(value, forKey: keyValue.rawValue)
    }
    
    // MAKR: Delete
    class func delete(keyValue: PreferenceKey) {
        UserDefaults.standard.removeObject(forKey: keyValue.rawValue)
    }
}
