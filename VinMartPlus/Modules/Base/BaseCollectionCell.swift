//
//  BaseCollectionCell.swift
//  LEORI
//
//  Created by KODAK on 9/11/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    class var cellID: String {
        return "BaseCollectionCell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    internal func setupViews() {
        
    }
    
}
