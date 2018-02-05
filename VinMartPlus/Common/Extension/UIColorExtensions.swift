//
//  UIColorExtensions.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/18/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(_ hex: Int, alpha: Double = 1.0) {
        
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(hex & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    class func rgba(red: Int, green: Int, blue: Int, alpha: Double = 1.0) -> UIColor {
        
        let r = CGFloat(Double(red) / 255.0)
        let g = CGFloat(Double(green) / 255.0)
        let b = CGFloat(Double(blue) / 255.0)
        
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
    
    class func horizontalGradient(from: UIColor, to: UIColor, width: CGFloat) throws -> UIColor {
        let size = CGSize(width: width, height: 1)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        guard let context = UIGraphicsGetCurrentContext() else {
            throw NSError(domain: "Can not create context", code: 0, userInfo: nil)
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [from.cgColor, to.cgColor] as CFArray
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil) else {
            throw NSError(domain: "Can not create gradient", code: 0, userInfo: nil)
        }
        let opts: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: width, y: 0), options: opts)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            throw NSError(domain: "Can not create image", code: 0, userInfo: nil)
        }
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image)
    }
    
    class func verticalGradient(from: UIColor, to: UIColor, height: CGFloat) throws -> UIColor {
        let size = CGSize(width: 1, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        guard let context = UIGraphicsGetCurrentContext() else {
            throw NSError(domain: "Can not create context", code: 0, userInfo: nil)
        }
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = [from.cgColor, to.cgColor] as CFArray
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil) else {
            throw NSError(domain: "Can not create gradient", code: 0, userInfo: nil)
        }
        let opts: CGGradientDrawingOptions = [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        context.drawLinearGradient(gradient, start: CGPoint(x: 0, y: 0), end: CGPoint(x: 0, y: height), options: opts)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            throw NSError(domain: "Can not create image", code: 0, userInfo: nil)
        }
        UIGraphicsEndImageContext()
        
        return UIColor(patternImage: image)
    }
}
