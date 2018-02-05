//
//  BottomView.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/20/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit

protocol CustomBottomViewDelegate: class {
    func didTapMessage()
    func didTapCard()
    func didTapBuyNow()
}

@IBDesignable class BottomView: UIView {
    @IBOutlet fileprivate weak var messageBnt: UIButton!
    @IBOutlet fileprivate weak var cardBnt: UIButton!
    
    weak var delegate: CustomBottomViewDelegate?
    
    class func instanceFromNib() -> BottomView {
        if let view = UINib(nibName: "BottomView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? BottomView {
         
            view.messageBnt.setImage(UIImage(named: "message")?.changeImageColor(tintColor: UIColor(0xFE5721)),
                                     for: .normal)
            view.cardBnt.setImage(UIImage(named: "cardbnt")?.changeImageColor(tintColor: UIColor(0xFE5721)),
                                     for: .normal)
            return view
        }
        
        return BottomView()
    }
    

    @IBAction func onMessageAction(_ sender: Any) {
        delegate?.didTapMessage()
    }
    
    @IBAction func onAddToCardAction(_ sender: Any) {
        delegate?.didTapCard()
    }
    
    @IBAction func onBuyNowAction(_ sender: Any) {
        delegate?.didTapBuyNow()
    }
}
