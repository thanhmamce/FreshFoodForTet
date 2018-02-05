//
//  UnderlinedLabel.swift
//  Rva Taxi


import UIKit

class UnderlinedLabel: UILabel {
    
    override var text: String! {
        
        didSet {
            // swift < 2. : let textRange = NSMakeRange(0, count(text))
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value:NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            
            self.attributedText = attributedText
        }
    }
    
    override func awakeFromNib() {
        let textRange = NSMakeRange(0, text.count)
        let attributedText = NSMutableAttributedString(string: self.text)
        attributedText.addAttribute(NSAttributedStringKey.underlineStyle , value:NSUnderlineStyle.styleSingle.rawValue, range: textRange)
        // Add other attributes if needed
        
        self.attributedText = attributedText
        
        self.isUserInteractionEnabled = true;
        let tapGesture = UITapGestureRecognizer.init(target:self, action: #selector(UnderlinedLabel.onLabelTouched_Event(_:))/*#selector(UnderlinedLabel.onLabelTouched_Event(_:))*/)
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc internal func onLabelTouched_Event(_ sender:AnyObject) {
        guard let text = self.text else {
            return
        }
        
        if self.verifyUrl(text) == true {
            if let url =  URL(string: text) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }
    
    func verifyUrl (_ urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url =  URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }
    
    
}
