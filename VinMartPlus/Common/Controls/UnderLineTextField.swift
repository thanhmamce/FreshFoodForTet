//
//  UnderLineTextField.swift
//  Rva Taxi


import UIKit

class UnderLineTextField: UITextField,UITextFieldDelegate {
    
    override func awakeFromNib() {
        self.borderStyle = .none
        self.delegate = self
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let border = CALayer()
        let width = CGFloat(0.7)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func drawText(in rect: CGRect)
    {
        super.drawText(in: rect)
        let border = CALayer()
        let width = CGFloat(0.7)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    override func drawPlaceholder(in rect: CGRect)
    {
        super.drawPlaceholder(in: rect)
        let border = CALayer()
        let width = CGFloat(0.7)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class imagedTextField: UITextField {
    
    override func awakeFromNib() {
        backgroundColor = UIColor.white
        font = UIFont.boldSystemFont(ofSize: 14)
        textAlignment = .center
        
        let imageView = UIImageView(image: UIImage(named: "ic_check"))
        imageView.backgroundColor = UIColor.clear
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        
        NSLayoutConstraint(item: imageView,
                           attribute: .width,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: 24.0).isActive = true
        NSLayoutConstraint(item: imageView,
                           attribute: .height,
                           relatedBy: .equal,
                           toItem: nil,
                           attribute: .notAnAttribute,
                           multiplier: 1.0,
                           constant: 24.0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .centerY,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .centerY,
                           multiplier: 1.0,
                           constant: 0.0).isActive = true
        NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: .equal,
                           toItem: imageView,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: 3.0).isActive = true
        
    }
    
}
