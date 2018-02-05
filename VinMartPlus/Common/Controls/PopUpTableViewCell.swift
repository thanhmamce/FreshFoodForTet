//
//  PopUpTableViewCell.swift
//  LEORI
//
//  Created by thanh nguyen on 11/27/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopUpTableViewCell: BaseTableCell {
    override class var cellID: String {
        return "PopUpTableViewCell"
    }
    
    //weak var delegate: PopOverCellActionsDelegate?
    
    lazy var bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(0x232526)
        view.cornerRadius = 10
        view.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .justified
        label.text = "The match will start at 8 p.m BST (3 a.m ET) and will be played at the Ullevaal Stadium in Osto, home of Norwegian national team."
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_menu"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func setupViews() {
        super.setupViews()
        
        backgroundColor = UIColor.clear
        
        addSubview(bubbleView)
        addSubview(contentLabel)
        addSubview(moreButton)
        
        bubbleView.leading(to: self, equal: 8).isActive = true
        bubbleView.top(to: self, equal: 0).isActive = true
        bubbleView.trailing(to: self, equal: -8).isActive = true
        bubbleView.bottom(to: self, equal: -8).isActive = true
        
        contentLabel.leading(to: bubbleView, equal: 30).isActive = true
        contentLabel.trailing(to: bubbleView, equal: -30).isActive = true
        contentLabel.fillVertical(to: bubbleView, equal: 20)
        
        moreButton.addTarget(self, action: #selector(onMoreButtonAction(_ :)), for: .touchUpInside)
        moreButton.trailing(to: bubbleView, equal: -8).isActive = true
        moreButton.top(to: bubbleView, equal: 0).isActive = true
        moreButton.width(equal: 25).isActive = true
        moreButton.height(equal: 25).isActive = true
    }
    
    @objc func onMoreButtonAction(_ sender: UIButton) {
        
    }
}
