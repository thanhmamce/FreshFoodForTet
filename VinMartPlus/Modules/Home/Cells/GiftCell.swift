//
//  GiftCell.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/18/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit

class GiftCell: BaseCollectionCell {
    override class var cellID: String {
        return "GiftCell"
    }
    
    var image: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.white
        
        addSubview(image)
        image.fill(to: self, equal: 10)
    }
}

class ProductView: BaseView {
    
    var imageWidth: NSLayoutConstraint!
    
    var imageIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.brown
        imageView.contentMode = .scaleToFill
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.orange
        label.textAlignment = .center
        label.backgroundColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageIcon)
        addSubview(nameLabel)
        addSubview(priceLabel)
        
        imageIcon.top(to: self).isActive = true
        imageIcon.centerX(to: self).isActive = true
        let width = UIScreen.main.bounds.width
        imageWidth = imageIcon.width(equal: (width - 2*85))
        imageWidth.isActive = true
        imageIcon.squareWidthHeight().isActive = true
        
        nameLabel.topToBottom(of: imageIcon, equal: 0).isActive = true
        nameLabel.fillHorizontal(to: self, equal: 15)
        
        priceLabel.top(to: nameLabel, withAttribute: .bottom).isActive = true
        priceLabel.fillHorizontal(to: self, equal: 15)
        priceLabel.bottom(to: self, lessOrEqual: -6).isActive = true
    }
}

class ProductTableCell: BaseTableCell {
    override class var cellID: String {
        return "productTableCell"
    }
    
    fileprivate var containView: ProductView = {
        let aView = ProductView()
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.backgroundColor = UIColor.white
        
        return aView
    }()
    
    var productImage: UIImage? {
        didSet {
            containView.imageIcon.image = productImage
        }
    }
    
    var name: String? {
        didSet {
            containView.nameLabel.text = name
        }
    }
    
    var price: String? {
        didSet {
            containView.priceLabel.text = price
        }
    }
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.white
        
        addSubview(containView)
        containView.fill(to: self, equal: 0)
    }
}

class ProductCollectionCell: BaseCollectionCell {
    override class var cellID: String {
        return "productCollectionCell"
    }
    
    fileprivate var containView: ProductView = {
        let aView = ProductView(frame: .zero)
        aView.translatesAutoresizingMaskIntoConstraints = false
        aView.backgroundColor = UIColor.white
        
        return aView
    }()
    
    var productImage: UIImage? {
        didSet {
            containView.imageIcon.image = productImage
        }
    }
    
    var name: String? {
        didSet {
            containView.nameLabel.text = name
        }
    }
    
    var price: String? {
        didSet {
            containView.priceLabel.text = price
        }
    }
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = UIColor.white
        
        addSubview(containView)
        containView.fill(to: self, equal: 0)
        containView.imageWidth.constant = (UIScreen.main.bounds.width - 15)/2
    }
}
