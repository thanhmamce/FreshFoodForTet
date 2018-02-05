//
//  PopupIndicatorViewCell.swift
//  LEORI
//
//  Created by thanh nguyen on 11/15/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopupIndicatorViewCell: BaseCollectionCell {
    override class var cellID: String {
        return "PopupIndicatorViewCell"
    }
    
    let indicatorView: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor(0xE81623)
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override internal func setupViews() {
        backgroundColor = UIColor.clear
        
        addSubview(indicatorView)
        indicatorView.height(equal: 3).isActive = true
        indicatorView.width(equal: 50).isActive = true
        indicatorView.centerX(to: self).isActive = true
        indicatorView.centerY(to: self).isActive = true
        indicatorView.cornerRadius = 1.5
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
