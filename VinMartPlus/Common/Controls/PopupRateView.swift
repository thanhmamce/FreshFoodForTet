//
//  PopupRateView
//  LEORI
//
//  Created by thanh nguyen on 11/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopupRateView: BaseView {

    weak var delegate: PopOverCellActionsDelegate?
    
    fileprivate lazy var container: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.white
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    let title: UILabel = {
        let aLabel = UILabel(frame: .zero)
        aLabel.font = UIFont.boldSystemFont(ofSize: 21)
        aLabel.textColor = UIColor.black
        aLabel.text = "RATE"
        aLabel.textAlignment = .left
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        return aLabel
    }()
    
    let textView: UITextView = {
        let aView = UITextView(frame: .zero)
        aView.textAlignment = .left
        aView.textColor = UIColor(0x95989a)
        aView.font = UIFont.systemFont(ofSize: 12)
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    private var stars = [UIImageView]()
    
    let leftButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor(0x353738)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(0x36383a).cgColor
        button.layer.borderWidth = 1
        button.cornerRadius = 7
        return button
    }()
    
    let rightButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor(0x353738)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor(0x36383a).cgColor
        button.layer.borderWidth = 1
        button.cornerRadius = 7
        return button
    }()
    
    var rate: Int = 5 {
        didSet {
            for i in 0...4 {
                if i <= (rate - 1) {
                    stars[i].alpha = 1
                } else {
                    stars[i].alpha = 0.5
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override internal func setupViews() {
        backgroundColor = UIColor.clear
        
        let topView = UIView(frame: .zero)
        topView.backgroundColor = UIColor.white
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topView)
        topView.top(to: self, equal: 2).isActive = true
        topView.height(equal: 3).isActive = true
        topView.width(equal: 50).isActive = true
        topView.centerX(to: self).isActive = true
        topView.cornerRadius = 1.5
        
        addSubview(container)
        container.top(to: topView, withAttribute: .bottom, equal: 10).isActive = true
        container.fillHorizontal(to: self)
        container.cornerRadius = 10
        
        let bottomView = UIView(frame: .zero)
        bottomView.backgroundColor = UIColor.white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomView)
        bottomView.height(equal: 3).isActive = true
        bottomView.width(equal: 50).isActive = true
        bottomView.centerX(to: self).isActive = true
        bottomView.top(to: container, withAttribute: .bottom, equal: 10).isActive = true
        bottomView.bottom(to: self).isActive = true
        bottomView.cornerRadius = 1.5
        
        // Setup Container
        container.addSubview(title)
        title.top(to: container, equal: 15).isActive = true
        title.leading(to: container, equal: 32).isActive = true
        
        container.addSubview(textView)
        textView.leading(to: container, equal: 25).isActive = true
        textView.trailing(to: container, equal: -25).isActive = true
        textView.top(to: title, withAttribute: .bottom, equal: 25).isActive = true
        
        container.addSubview(leftButton)
        container.addSubview(rightButton)
        
        leftButton.leading(to: textView).isActive = true
        leftButton.trailing(to: rightButton, withAttribute: .leading, equal: -5).isActive = true
        leftButton.bottom(to: container, equal: -15).isActive = true
        leftButton.height(equal: 25).isActive = true
        
        rightButton.trailing(to: textView).isActive = true
        rightButton.bottom(to: leftButton).isActive = true
        rightButton.height(equal: 25).isActive = true
        rightButton.width(equalTo: leftButton).isActive = true
        
        var lastView: UIImageView?
        stars.removeAll()
        for i in 0...4 {
            let aImageView = UIImageView(frame: .zero)
            stars.append(aImageView)
            container.addSubview(aImageView)
            aImageView.tag = 100 + i
            aImageView.image = UIImage(named: "ic_rating_star")
            aImageView.alpha = 0.5
            aImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(onTapGestureHandle(_ :)))
            aImageView.addGestureRecognizer(tap)
            aImageView.translatesAutoresizingMaskIntoConstraints = false
            
            if let last = lastView {
                aImageView.leading(to: last, withAttribute: .trailing, equal: 5).isActive = true
                aImageView.height(equalTo: last).isActive = true
                aImageView.width(equalTo: last).isActive = true
                aImageView.bottom(to: last).isActive = true
            } else {
                aImageView.top(to: textView, withAttribute: .bottom, equal: 10).isActive = true
                aImageView.bottom(to: leftButton, withAttribute: .top, equal: -10).isActive = true
                aImageView.height(equal: 25).isActive = true
                aImageView.width(equal: 25).isActive = true
                aImageView.leading(to: self, greaterOrEqual: 0).isActive = true
            }
            
            if i == 2 {
                aImageView.centerX(to: self).isActive = true
            }
            lastView = aImageView
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func onTapGestureHandle(_ sender: UITapGestureRecognizer) {
        if let tag = sender.view?.tag {
            for i in 0...4 {
                if i <= (tag - 100) {
                    stars[i].alpha = 1
                } else {
                    stars[i].alpha = 0.5
                }
            }
        }
    }
}
