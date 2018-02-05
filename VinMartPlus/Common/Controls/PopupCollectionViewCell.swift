//
//  PopupTableViewCell.swift
//  LEORI
//
//  Created by THANH on 11/08/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopupCollectionViewCell: BaseCollectionCell {
    override class var cellID: String {
        return "PopupCollectionViewCell"
    }
    
    let title: UILabel = {
        let aTitle = UILabel(frame: .zero)
        aTitle.textAlignment = .center
        aTitle.translatesAutoresizingMaskIntoConstraints = false
        return aTitle
    }()
    
    fileprivate var _isSelected: Bool = false
    
    override var isSelected: Bool {
        get {
            return _isSelected
        }
        set {
            _isSelected = newValue
            if _isSelected {
                self.backgroundColor = UIColor.lightGray
            } else {
                self.backgroundColor = UIColor(0xE81623)
            }
        }
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override internal func setupViews() {
        backgroundColor = UIColor(0xE81623)
        
        addSubview(title)
        title.trailing(to: self, equal: 8).isActive = true
        title.leading(to: self, equal: 8).isActive = true
        title.centerY(to: self).isActive = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
