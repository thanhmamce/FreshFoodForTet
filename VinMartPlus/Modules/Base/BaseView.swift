//
//  BaseView.swift
//  LEORI
//
//  Created by KODAK on 9/13/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    func setupViews() {
        backgroundColor = .clear
    }
    
}
