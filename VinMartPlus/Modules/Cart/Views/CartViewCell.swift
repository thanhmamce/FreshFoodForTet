//
//  CartViewCell.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/19/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit
import GMStepper

protocol CartViewCellDelegate: class {
    func didClickDeleteButton(_ cell: UITableViewCell)
    func updatePriceSum(with cell: UITableViewCell, delta: Int)
}

class CartViewCell: BaseTableCell {
    override class var cellID: String {
        return "CartViewCell"
    }
    
    weak var delegate: CartViewCellDelegate?
    
    fileprivate var productsCount = 0
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "delete"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let iconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor(0x252525)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(0x252525)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stepperBnt: GMStepper = {
        let stepper = GMStepper()
        stepper.buttonsTextColor = UIColor.gray.withAlphaComponent(0.8)
        stepper.labelTextColor = UIColor.black
        stepper.labelFont = UIFont.systemFont(ofSize: 18)
        stepper.labelBackgroundColor = UIColor.white
        stepper.buttonsBackgroundColor = UIColor.white
        stepper.backgroundColor = UIColor.white
        stepper.minimumValue = 1.0
        stepper.translatesAutoresizingMaskIntoConstraints = false
        
        return stepper
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.white
        productsCount = 1
        
        addSubview(deleteButton)
        addSubview(iconImage)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(stepperBnt)
        
        deleteButton.addTarget(self, action: #selector(handleDeleteButtonClicked(_:)), for: .touchUpInside)
        deleteButton.trailing(to: self, equal: -10).isActive = true
        deleteButton.width(equal: 32).isActive = true
        deleteButton.squareWidthHeight().isActive = true
        deleteButton.centerY(to: self).isActive = true
        
        iconImage.leading(to: self, equal: 10).isActive = true
        iconImage.width(equal: 80).isActive = true
        iconImage.squareWidthHeight().isActive = true
        iconImage.top(to: self, equal: 4).isActive = true
        
        priceLabel.trailing(to: deleteButton, equal: 10).isActive = true
        priceLabel.leadingToTrailing(of: iconImage, equal: 10).isActive = true
        priceLabel.top(to: self, withAttribute: .centerY, equal: 5).isActive = true
        
        stepperBnt.addTarget(self, action: #selector(stepperValueChanged(_ :)), for: .valueChanged)
        stepperBnt.width(equal: 60).isActive = true
        stepperBnt.height(equal: 32).isActive = true
        stepperBnt.leadingToTrailing(of: iconImage, equal: 10).isActive = true
        stepperBnt.bottom(to: self, withAttribute: .centerY, equal: -5).isActive = true
        
        nameLabel.leading(to: iconImage, equal: 0).isActive = true
        nameLabel.topToBottom(of: iconImage, equal: 10).isActive = true
        nameLabel.trailing(to: self).isActive = true
        nameLabel.bottom(to: self).isActive = true
    }
    
    @objc func handleDeleteButtonClicked(_ sender: UIButton) {
        delegate?.didClickDeleteButton(self)
    }
    
    @objc func stepperValueChanged(_ stepper: GMStepper) {
        let oldCount = productsCount
        productsCount = Int(stepper.value)
        delegate?.updatePriceSum(with: self, delta: (productsCount - oldCount))
    }
}

//extension GMStepper {
//    func disableButtonIfNeed() {
//        if self.value == self.minimumValue {
//
//        }
//    }
//}

