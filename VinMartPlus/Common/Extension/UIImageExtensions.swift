//
//  UIImageExtensions.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/18/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Returns a image that fills in newSize
    func resizedImage(_ newSize: CGSize) -> UIImage? {
        // Guard newSize is different
        guard self.size != newSize else { return self }
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    /// Returns a resized image that fits in rectSize, keeping it's aspect ratio
    /// Note that the new image size is not rectSize, but within it.
    func resizedImageWithinRect(_ rectSize: CGSize) -> UIImage? {
        let widthFactor = size.width / rectSize.width
        let heightFactor = size.height / rectSize.height
        
        var resizeFactor = widthFactor
        if size.height > size.width {
            resizeFactor = heightFactor
        }
        
        let newSize = CGSize(width: size.width/resizeFactor, height: size.height/resizeFactor)
        let resized = resizedImage(newSize)
        return resized
    }
    
    func tintedImageWithColor(tintColor:UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        
        let bounds = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        self.draw(in: bounds)
        tintColor.set()
        UIRectFillUsingBlendMode(bounds, CGBlendMode.color)
        
        self.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        
        let tintImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintImage!
    }
    
    
    func changeImageColor(tintColor: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    class func imageWithOnlyColor(color: UIColor, size: CGSize) -> UIImage
    {
        let view = UIView(frame: CGRect(x:0, y:0, width: size.width, height:size.height))
        view.backgroundColor = color
        return view.snapshot()
    }
    
    func changeImageSize(newWidth: CGFloat, newHeight: CGFloat) -> UIImage
    {
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width:newWidth, height:newHeight), false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()! as CGContext
        context.translateBy(x: 0, y: newHeight)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        context.clip(to: rect, mask: self.cgImage!)
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
        UIGraphicsEndImageContext()
        
        return newImage
        
    }
    
    static func createRoundedUIImageForDeviceIcon(_ baseBackgroundColor: UIColor, imageHeightWidth: CGFloat, borderColor: UIColor, borderWidth: CGFloat) -> UIImage {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: imageHeightWidth, height: imageHeightWidth))
        view.backgroundColor = baseBackgroundColor
        view.layer.cornerRadius = view.frame.width/2.0
        view.clipsToBounds = true
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth/UIScreen.main.scale
        return view.snapshot()
    }
    
    static func createRoundedUIImageWith(_ baseImage: UIImage, imageHeightWidth: CGFloat) -> UIImage {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageHeightWidth, height: imageHeightWidth))
        imageView.image = baseImage
        imageView.layer.cornerRadius = imageView.frame.width/2.0
        imageView.clipsToBounds = true
        return imageView.snapshot()
    }
    
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    static func createUIImageOnDemand(_ baseBackgroundColor: UIColor, borderColor: UIColor, imageWidth: CGFloat, imageHeight: CGFloat, borderWidth: CGFloat, cornerRadius : CGFloat = 0.0 ) -> UIImage {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        view.backgroundColor = baseBackgroundColor
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = borderWidth
        return view.snapshot()
    }
    
    static func createLowResolutionThumbnailFrom(imageData : Data, size: CGSize) -> UIImage?
    {
        if let image = UIImage(data: imageData)
        {
            UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
            image.draw(in: CGRect(origin: CGPoint.zero, size: size))
            let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return scaledImage
        }
        return nil
        
    }
    
    func setOpacity(_ alpha:CGFloat)->UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    // retrun an image with a specific background frame as per specified paramters
    static func loadImageWithBackgroundFrame(named: String, imageHeight: CGFloat, imageWidth: CGFloat, holderViewHeight: CGFloat, holderViewWidth: CGFloat, holderViewBackgroundColor : UIColor, holderViewBorderWidth: CGFloat, holderViewBorderColor: UIColor) -> UIImage
    {
        let holderView = UIView(frame: CGRect(x: 0, y: 0, width: holderViewWidth, height: holderViewHeight))
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
        let image = UIImage(named: named)
        
        holderView.layer.borderColor = holderViewBorderColor.cgColor
        holderView.layer.borderWidth = holderViewBorderWidth
        holderView.backgroundColor = holderViewBackgroundColor
        imageView.center = holderView.center
        imageView.image = image
        
        holderView.addSubview(imageView)
        
        return holderView.snapshot()
    }
    
    static func getSwitchButtonImage(on state: Bool, totalWidth: CGFloat, totalHeight: CGFloat, trackWidth: CGFloat, trackHeight: CGFloat, roundedThumbDimention: CGFloat, trackColor: UIColor, thumbColor: UIColor) -> UIImage {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: totalWidth, height: totalHeight))
        view.backgroundColor = UIColor.clear
        
        let trackView = UIView(frame: CGRect(x: 0, y: 0, width: trackWidth, height: trackHeight))
        
        trackView.layer.cornerRadius = trackHeight / 2.0
        trackView.clipsToBounds = true
        trackView.backgroundColor = trackColor
        trackView.center = view.center
        view.addSubview(trackView)
        
        let thumbStart : CGFloat = state ? totalWidth - roundedThumbDimention : 0.0
        let thumbImageView = UIImageView(frame: CGRect(x: thumbStart, y: (totalHeight - roundedThumbDimention) / 2.0, width: roundedThumbDimention, height: roundedThumbDimention))
        thumbImageView.image = UIImage.createUIImageOnDemand(thumbColor, borderColor: trackColor, imageWidth: roundedThumbDimention, imageHeight: roundedThumbDimention, borderWidth: 1.0 / UIScreen.main.scale, cornerRadius: 26.0/2.0)
        view.addSubview(thumbImageView)
        
        return view.snapshot()
    }
    
    static func getPowerButtonImage(backgroundColor: UIColor, powerIconColor: UIColor, buttonDimention: CGFloat = 37.0, powerIconDimention: CGFloat = 23) -> UIImage? {
        let image = UIImage(named:"sc_action_ic_start")?.changeImageColor(tintColor: powerIconColor)
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: buttonDimention, height: buttonDimention))
        
        
        view.backgroundColor = backgroundColor
        view.clipsToBounds = true
        view.layer.cornerRadius = CGFloat(buttonDimention / 2.0)
        
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: powerIconDimention, height: powerIconDimention))
        imageView.center = view.center
        imageView.image = image
        
        view.addSubview(imageView)
        
        return view.snapshot()
    }
    
    static func getDefaultSwitchImage(on state : Bool, height : CGFloat, width : CGFloat, onStateTintColor : UIColor, offStateTintColor : UIColor) -> UIImage {
        
        let switchButton = UISwitch()
        let actualHeight = switchButton.frame.height
        let actualWidth = switchButton.frame.width
        let xRatio = CGFloat(width/actualWidth)
        let yRatio = CGFloat(height/actualHeight)
        switchButton.transform = CGAffineTransform.init(scaleX: xRatio, y: yRatio)
        
        switchButton.tintColor = offStateTintColor
        switchButton.onTintColor = onStateTintColor
        switchButton.thumbTintColor = switchButton.backgroundColor
        switchButton.isOn = state
        switchButton.layer.shadowOpacity = 0.0
        return switchButton.snapshot()
    }
}
