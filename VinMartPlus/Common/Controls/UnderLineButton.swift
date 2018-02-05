//
//  UnderLineButton.swift
//  Rva Taxi


import UIKit

class UnderLineButton: UIButton {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        let attrs = [NSAttributedStringKey.underlineStyle : 1 as Any, NSAttributedStringKey.foregroundColor : UIColor.init(0xFFCC00, alpha: 1.0) as Any]
        
        let attributedString = NSMutableAttributedString(string:"")
        
        let buttonTitleStr = NSMutableAttributedString(string:self.currentTitle!, attributes:attrs)
        attributedString.append(buttonTitleStr)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle , value:NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, self.currentTitle!.count))
        
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
