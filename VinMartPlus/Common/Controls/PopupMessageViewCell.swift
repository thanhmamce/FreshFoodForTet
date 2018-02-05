//
//  PopupMessageViewCell.swift
//  LEORI
//
//  Created by thanh nguyen on 11/27/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopupMessageViewCell: BaseCollectionCell {
    override class var cellID: String {
        return "PopupMessageViewCell"
    }
    
    weak var delegate: PopOverCellActionsDelegate?
    
    let title: UILabel = {
        let aTitle = UILabel(frame: .zero)
        aTitle.textAlignment = .left
        aTitle.translatesAutoresizingMaskIntoConstraints = false
        return aTitle
    }()
    
    let iconImage: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage()
        icon.contentMode = .scaleToFill
        icon.borderColor = UIColor(0x95989a)
        icon.borderWidth = 2
        icon.cornerRadius = 7
        icon.translatesAutoresizingMaskIntoConstraints = false
        return icon
    }()
    
    let messageButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(0x4D4D4D).cgColor
        button.layer.borderWidth = 1
        button.cornerRadius = 7
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override internal func setupViews() {
        backgroundColor = UIColor.white
        
        addSubview(iconImage)
        iconImage.height(equal: 40).isActive = true
        iconImage.width(equal: 40).isActive = true
        iconImage.leading(to: self, equal: 25).isActive = true
        iconImage.centerY(to: self).isActive = true
        
        addSubview(title)
        title.leading(to: iconImage, withAttribute: .trailing, equal: 15).isActive = true
        title.fillVertical(to: self)
        
        let width = "Message".widthWithConstrainedHeight(height: 25, font: UIFont.systemFont(ofSize: 14))
        addSubview(messageButton)
        messageButton.addTarget(self, action: #selector(onMessageAction(_ :)), for: .touchUpInside)
        messageButton.leading(to: title, withAttribute: .trailing).isActive = true
        messageButton.trailing(to: self, equal: -25).isActive = true
        messageButton.height(equal: 25).isActive = true
        messageButton.width(equal: width + 18).isActive = true
        messageButton.centerY(to: self).isActive = true
        messageButton.setTitle("Message", for: .normal)
        messageButton.setTitleColor(UIColor(0x4d4d4d), for: .normal)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func onMessageAction(_ sender: UIButton) {
        delegate?.didClickSendMessage()
    }
}
