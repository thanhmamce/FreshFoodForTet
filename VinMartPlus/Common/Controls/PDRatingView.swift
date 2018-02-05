//
//  PDRatingView.swift
//  LEORI
//
//  Created by KODAK on 11/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PDRatingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    var rating: Int = 5 {
        didSet {
            v1.alpha = rating>=1 ? 1 : 0.2
            v2.alpha = rating>=2 ? 1 : 0.2
            v3.alpha = rating>=3 ? 1 : 0.2
            v4.alpha = rating>=4 ? 1 : 0.2
            v5.alpha = rating>=5 ? 1 : 0.2
        }
    }
    
    fileprivate lazy var v1: UIImageView = {
        return self.createStarView()
    }()
    
    fileprivate lazy var v2: UIImageView = {
        return self.createStarView()
    }()
    
    fileprivate lazy var v3: UIImageView = {
        return self.createStarView()
    }()
    
    fileprivate lazy var v4: UIImageView = {
        return self.createStarView()
    }()
    
    fileprivate lazy var v5: UIImageView = {
        return self.createStarView()
    }()
    
    fileprivate func setupViews() {
        backgroundColor = .white
        
        addSubview(v1)
        addSubview(v2)
        addSubview(v3)
        addSubview(v4)
        addSubview(v5)
        
        v1.fillVertical(to: self)
        v1.leading(to: self).isActive = true
        v1.squareWidthHeight().isActive = true
        
        v2.leading(to: v1, withAttribute: .trailing, equal: 1).isActive = true
        v2.width(equalTo: v1).isActive = true
        v2.height(equalTo: v1).isActive = true
        v2.centerY(to: v1).isActive = true
        
        v3.leading(to: v2, withAttribute: .trailing, equal: 1).isActive = true
        v3.width(equalTo: v1).isActive = true
        v3.height(equalTo: v1).isActive = true
        v3.centerY(to: v2).isActive = true
        
        v4.leading(to: v3, withAttribute: .trailing, equal: 1).isActive = true
        v4.width(equalTo: v1).isActive = true
        v4.height(equalTo: v1).isActive = true
        v4.centerY(to: v3).isActive = true
        
        v5.leading(to: v4, withAttribute: .trailing, equal: 1).isActive = true
        v5.width(equalTo: v1).isActive = true
        v5.height(equalTo: v1).isActive = true
        v5.centerY(to: v4).isActive = true
    }
    
    fileprivate func createStarView() -> UIImageView {
        let view = UIImageView()
        view.image = UIImage(named: "ic_rating_star")?.withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .clear
        view.tintColor = UIColor(0xFCAF17)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}
