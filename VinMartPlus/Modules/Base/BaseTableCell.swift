//
//  BaseTableCell.swift
//  LEORI
//
//  Created by KODAK on 9/12/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
//import SwipeCellKit

class BaseTableCell: UITableViewCell {
    class var cellID: String {
        return "BaseTableCell"
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupViews()
    }
    
    internal func setupViews() {
        selectionStyle = .none
    }
    
}
