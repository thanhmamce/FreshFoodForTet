//
//  PreviewViewController.swift
//  Print2PDF
//
//  Created by Gabriel Theodoropoulos on 14/06/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit

class AddressInfoViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIGestureRecognizerDelegate {
    @IBOutlet fileprivate weak var name: UITextField!
    @IBOutlet fileprivate weak var phoneNumber: UITextField!
    @IBOutlet fileprivate weak var email: UITextField!
    @IBOutlet fileprivate weak var address: UITextView!
    
    weak var delegate: ProductPagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapGesture(_ :)))
        self.view.addGestureRecognizer(tapGesture)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.checkAllFieldedIsFilled() {
            delegate?.enableBottomBnt()
        }
        
        name.becomeFirstResponder()
    }
    
    fileprivate func checkAllFieldedIsFilled() -> Bool {
        if let name = self.name.text, let phone = self.phoneNumber.text, let email = self.email.text, let address = self.address.text {
            
            if name.isEmpty {
                return false
            }
            
            if phone.isEmpty {
                return false
            }
            
            if email.isEmpty {
                return false
            }
            
            if address.isEmpty {
                return false
            }
            
            return true
        }
        
        return false
    }
    
    @objc fileprivate func onTapGesture(_ gesture: UITapGestureRecognizer) {
        self.name.resignFirstResponder()
        self.phoneNumber.resignFirstResponder()
        self.email.resignFirstResponder()
        self.address.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if self.checkAllFieldedIsFilled() {
            delegate?.enableBottomBnt()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if self.checkAllFieldedIsFilled() {
            delegate?.enableBottomBnt()
        }
    }
    
    func getAddressInfo() -> (name: String, phone: String, email: String, address: String) {
        return (self.name.text ?? "", self.phoneNumber.text ?? "", self.email.text ?? "", self.address.text ?? "")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
