//
//  PaddingLabel.swift
//  LEORI
//
//  Created by KODAK on 11/15/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PaddingLabel: UILabel {
    var contentInsets: UIEdgeInsets = .zero {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override public var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + contentInsets.left + contentInsets.right, height: size.height + contentInsets.top + contentInsets.bottom)
    }
    
    override public func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, contentInsets))
    }
}
