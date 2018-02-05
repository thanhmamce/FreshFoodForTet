//
//  HomeHeaderCell.swift
//  LEORI
//
//  Created by KODAK on 9/6/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class HomeHeaderCell: BaseCollectionCell {
    override class var cellID: String {
        return "HomeHeaderCell"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.text = "Các sản phẩm khác của Shop"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.orange
        label.textAlignment = .left
        label.text = "Các loại gói quà"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        titleLabel.leading(to: self, equal: 0).isActive = true
        titleLabel.top(to: self).isActive = true
        titleLabel.trailing(to: self, equal: 0).isActive = true
        titleLabel.height(equal: 26).isActive = true
        
        addSubview(subTitleLabel)
        subTitleLabel.leading(to: self, equal: 15).isActive = true
        subTitleLabel.topToBottom(of: titleLabel, equal: 6).isActive = true
        subTitleLabel.trailing(to: self, equal: -15).isActive = true
        subTitleLabel.height(equal: 22).isActive = true
    }
}

class HomeDetailHeaderCell: BaseCollectionCell {
    override class var cellID: String {
        return "HomeDetailHeaderCell"
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.orange
        label.text = "Các sản phẩm khác"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = .clear
        
        addSubview(titleLabel)
        
        titleLabel.fillVertical(to: self)
        titleLabel.fillHorizontal(to: self, equal: 15)
    }
}
