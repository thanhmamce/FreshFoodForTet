//
//  PDProgressView.swift
//  LEORI
//
//  Created by KODAK on 11/20/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PDProgressView: UIView {
    var progress: CGFloat = 0.5 {
        didSet {
            let string = self.text ?? "Your sample text here"
            
            self.progressLabel.text = string
            self.maskedProgressLabel.text = string
            
            let w: CGFloat = (self.bounds.size.width - self.borderWidth*2)
            if w>=0 {
                progressBarWidthConstraint.constant = progress * w
                progressBarMaskWidthConstraint.constant = progressBarWidthConstraint.constant
            }
            
            self.layoutIfNeeded()
            
            self.updateMask()
        }
    }
    
    var text: String? {
        didSet {
            self.progressLabel.text = text
            self.maskedProgressLabel.text = text
        }
    }
    
    var normalTextColor: UIColor = .black {
        didSet {
            self.progressLabel.textColor = normalTextColor
        }
    }
    
    var maskedTextColor: UIColor = .white {
        didSet {
            self.maskedProgressLabel.textColor = maskedTextColor
        }
    }
    
    fileprivate var _cornerRadius: CGFloat = 10
    override var cornerRadius: CGFloat {
        get {
            return _cornerRadius
        }
        set {
            _cornerRadius = newValue
            self.setNeedsLayout()
        }
    }
    
    fileprivate var _borderWidth: CGFloat = 1
    override var borderWidth: CGFloat {
        get {
            return _borderWidth
        }
        set {
            _borderWidth = newValue
            self.setNeedsLayout()
        }
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            self.progressBar.backgroundColor = backgroundColor
        }
    }
    
    fileprivate lazy var container: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var progressBar: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate lazy var progressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = self.normalTextColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var maskedProgressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = self.maskedTextColor
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate lazy var maskedView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate var progressBarWidthConstraint: NSLayoutConstraint!
    fileprivate var progressBarMaskWidthConstraint: NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        initView()
        addAllConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radiusOutside = self.cornerRadius
        let radiusInside = radiusOutside - self.borderWidth
        guard radiusOutside > 0, radiusInside > 0 else { return }
        
        let maskLayer1 = CAShapeLayer()
        maskLayer1.path = UIBezierPath(roundedRect: self.container.bounds,
                                       byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight],
                                       cornerRadii: CGSize(width: radiusInside, height: radiusInside)).cgPath
        
        self.container.layer.mask = maskLayer1
        
        let maskLayer2 = CAShapeLayer()
        maskLayer2.path = UIBezierPath(roundedRect: self.bounds,
                                       byRoundingCorners: [UIRectCorner.topRight, UIRectCorner.bottomRight],
                                       cornerRadii: CGSize(width: radiusOutside, height: radiusOutside)).cgPath
        maskLayer2.backgroundColor = UIColor.red.cgColor
        self.layer.mask = maskLayer2
    }
    
    fileprivate func initView() {
        self.backgroundColor = UIColor(red: 99/255, green: 99/255, blue: 99/255, alpha: 1)
        self.cornerRadius = 10
        self.borderWidth = 1
        
        self.normalTextColor = .black
        self.maskedTextColor = .white
        
        self.container.addSubview(self.progressBar)
        self.container.addSubview(self.progressLabel)
        self.container.addSubview(self.maskedProgressLabel)
        self.container.addSubview(self.maskedView)
        
        self.addSubview(self.container)
    }
    
    fileprivate func addAllConstraints() {
        // Container
        NSLayoutConstraint(item: self.container,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: self.borderWidth).isActive = true
        NSLayoutConstraint(item: self.container,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: -self.borderWidth).isActive = true
        NSLayoutConstraint(item: self.container,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: self.borderWidth).isActive = true
        NSLayoutConstraint(item: self.container,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: -self.borderWidth).isActive = true
        
        // Progress bar
        NSLayoutConstraint(item: self.progressBar,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.progressBar,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.progressBar,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        progressBarWidthConstraint = NSLayoutConstraint(item: self.progressBar,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 10.0,
                                                        constant: 0)
        progressBarWidthConstraint.isActive = true
        
        // Progress label
        NSLayoutConstraint(item: self.progressLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.progressLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.progressLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.progressLabel,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        // Masked Progress label
        NSLayoutConstraint(item: self.maskedProgressLabel,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.maskedProgressLabel,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.maskedProgressLabel,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.maskedProgressLabel,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        
        // Masked view
        NSLayoutConstraint(item: self.maskedView,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.maskedView,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        NSLayoutConstraint(item: self.maskedView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: self.container,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: 0).isActive = true
        progressBarMaskWidthConstraint = NSLayoutConstraint(item: self.maskedView,
                                                            attribute: .width,
                                                            relatedBy: .equal,
                                                            toItem: nil,
                                                            attribute: .notAnAttribute,
                                                            multiplier: 10.0,
                                                            constant: 0)
        progressBarMaskWidthConstraint.isActive = true
        
    }
    
    fileprivate func updateMask() {
        let maskLayer = CAShapeLayer()
        let maskRect = CGRect(x: 0,
                              y: 0,
                              width: progressBarMaskWidthConstraint.constant,
                              height: self.maskedView.bounds.size.height)
        let path = CGPath(rect: maskRect, transform: nil)
        maskLayer.path = path
        self.maskedProgressLabel.layer.mask = maskLayer
    }
}
