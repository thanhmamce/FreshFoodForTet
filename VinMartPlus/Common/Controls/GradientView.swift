//
//  GradientView.swift
//  LEORI
//
//  Created by KODAK on 11/1/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
import QuartzCore

/*@IBDesignable */class GradientView: UIView {
    
    @IBInspectable var firstGradientColor: UIColor = .white {
        didSet {
            setupGradient()
        }
    }
    
    @IBInspectable var secondGradientColor: UIColor = .white {
        didSet {
            setupGradient()
        }
    }
    
    @IBInspectable var isHorizontalGradient: Bool = false {
        didSet {
            setupGradient()
        }
    }
    
    override class var layerClass:AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func setupGradient() {
        let color1 = firstGradientColor
        let color2 = secondGradientColor
        
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.cornerRadius = cornerRadius
        
        if (isHorizontalGradient) {
            gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        } else {
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        }
        
        self.setNeedsDisplay()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds" {
//            setupGradient()
            self.setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "bounds")
    }
    
    fileprivate func setupViews() {
        self.addObserver(self, forKeyPath: "bounds", options: .new, context: nil)
    }
}
