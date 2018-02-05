//
//  UserColCell.swift
//  LEORI
//
//  Created by KODAK on 11/28/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol UserColCellInterface: class {
    func gotoCardTab()
}

class UserColCell: BaseCollectionCell {
    override class var cellID: String {
        return "UserColCell"
    }
    
    weak var delegate: UserColCellInterface?
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "VMP_sungtuc")
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor(0xeff0f0)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Name"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.sizeToFit()
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.backgroundColor = UIColor(0xeff0f0)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.text = "Price"
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var reactButton: UIButton = {
        let button = UIButton()
        button.setTitle("Mua ngay", for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.orange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.white
        
        addSubview(profileImageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(reactButton)
        
        profileImageView.top(to: self).isActive = true
        profileImageView.fillHorizontal(to: self)
        
        nameLabel.topToBottom(of: profileImageView, equal: -2).isActive = true
        nameLabel.fillHorizontal(to: self)
        nameLabel.height(greaterOrEqual: 26).isActive = true
        nameLabel.height(lessOrEqual: 40).isActive = true
        
        priceLabel.top(to: nameLabel, withAttribute: .bottom).isActive = true
        priceLabel.fillHorizontal(to: self)
        priceLabel.height(greaterOrEqual: 20).isActive = true
        priceLabel.height(lessOrEqual: 36).isActive = true
        priceLabel.bottom(to: self, equal: -6).isActive = true
        
//        reactButton.addTarget(self, action: #selector(onReactButtonAction(_ :)), for: .touchUpInside)
//        reactButton.topToBottom(of: priceLabel).isActive = true
//        reactButton.fillHorizontal(to: self)
//        reactButton.bottom(to: self).isActive = true
//        reactButton.height(equal: 40).isActive = true
    }
    
    @objc func onReactButtonAction(_ sender: AnyObject) {
        delegate?.gotoCardTab()
    }
}
