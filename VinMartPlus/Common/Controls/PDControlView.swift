//
//  PDControlView.swift
//  LEORI
//
//  Created by KODAK on 11/20/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PDControlView: BaseView {
    
    fileprivate var allWidthConstraints = [NSLayoutConstraint]()
    
    @IBInspectable var numberOfPages: Int = 0 {
        didSet {
            reloadSubViews()
        }
    }
    
    var isEmpty: Bool {
        return (numberOfPages == 0)
    }
    
    fileprivate var _currentPage: Int = 0
    @IBInspectable var currentPage: Int {
        get {
            return _currentPage
        }
        set {
            guard !allWidthConstraints.isEmpty, 0..<numberOfPages ~= newValue else { return }
            
            let lastConstraint = allWidthConstraints[_currentPage]
            lastConstraint.constant = 15
            let newConstraint = allWidthConstraints[newValue]
            newConstraint.constant = 25
            _currentPage = newValue
            self.setNeedsUpdateConstraints()
        }
    }
    
    fileprivate var contentViewWidthConstraint: NSLayoutConstraint?
    fileprivate lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(contentView)
        contentView.fillVertical(to: self)
        contentView.centerX(to: self).isActive = true
        contentView.width(greaterOrEqual: 0).isActive = true
//        contentViewWidthConstraint = contentView.width(equal: 0)
//        contentViewWidthConstraint?.isActive = true
    }
    
    fileprivate func reloadSubViews() {
        guard numberOfPages > 0 else { return }
        
        contentView.subviews.forEach { $0.removeFromSuperview() }
        allWidthConstraints.removeAll()
        
        var lastView: UIView?
        for index in 0..<numberOfPages {
            let view = getDotView()
            contentView.addSubview(view)
            
            if let lastView = lastView {
                view.leading(to: lastView, withAttribute: .trailing, equal: 5).isActive = true
            } else {
                view.leading(to: contentView).isActive = true
            }
            
            view.height(equal: 3).isActive = true
            view.centerY(to: contentView).isActive = true
            
            let w: CGFloat = index == currentPage ? 25 : 15
            let constraint = view.width(equal: w)
            constraint.isActive = true
            allWidthConstraints.append(constraint)

            lastView = view
        }
        lastView?.trailing(to: contentView).isActive = true
        
//        let totalWidth: CGFloat = CGFloat(numberOfPages*15 + (25-15) + (numberOfPages-1)*5)
//        contentViewWidthConstraint?.constant = totalWidth
        self.setNeedsUpdateConstraints()
    }
    
    fileprivate func getDotView() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(0xBBBBBB)
        view.layer.cornerRadius = 1.5
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
