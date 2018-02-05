//
//  SubmitProductViewController.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/20/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit
import MessageUI

let bntTexts = ["Chuyển sang thanh toán", "Chuyển sang đặt hàng", "Đặt hàng"]
let topImages = [UIImage(named: "status_0"), UIImage(named: "status_1"), UIImage(named: "status_2")]

class SubmitProductViewController: BaseViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet fileprivate weak var topImageView: UIImageView!
    @IBOutlet fileprivate weak var bottomBnt: UIButton!
        
    fileprivate lazy var backButton: UIBarButtonItem = {
        let aButton = UIBarButtonItem(image: UIImage(named: "back"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onBackButtonClicked(_:)))
        aButton.tintColor = UIColor(0xFAC090)
        return aButton
    }()
    
    fileprivate weak var pager: Pager?
    
    fileprivate var customerName: String = ""
    fileprivate var phone: String = ""
    fileprivate var email: String = ""
    fileprivate var address: String = ""
    fileprivate var methodTransfer: String = "Đến cửa hàng thanh toán"
    fileprivate var mailSubject: String = ""
    fileprivate var total: Int = 0
    fileprivate var savedShopInfo: [String: String]?
    fileprivate var items = [[String: String]]()
    
    static func newFromStoryboard(with products: [[String: String]] = [], totalPrice: Int) -> SubmitProductViewController? {
        guard let view = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "SubmitProductViewController") as? SubmitProductViewController else {
            return nil
        }
        
        view.items.removeAll()
        view.items.append(contentsOf: products)
        view.total = totalPrice
        
        return view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pager_pay" {
            if let destination = segue.destination as? Pager {
                pager = destination
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        if let shopInfo = UserDefaults.standard.object(forKey: "vmpShopInfo") as? [String: String] {
            self.savedShopInfo = shopInfo
        }
        self.preparePager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let image = topImages[0]
        topImageView.image = image
        bottomBnt.setTitle(bntTexts[0], for: .normal)
        bottomBnt.isEnabled = false
        bottomBnt.alpha = 0.3
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }

    fileprivate func preparePager() {
        guard let pager = pager else { return }
        
        pager.pageDelegate = self
        pager.customPageDelegate = self
    }
    
    @objc func onBackButtonClicked(_ sender: AnyObject) {
        guard let index = pager?.currentPageIndex else { return }
        
        if index == 0 {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        pager?.moveBack()
        let image = topImages[index - 1]
        topImageView.image = image
        bottomBnt.setTitle(bntTexts[index - 1], for: .normal)
    }
    
    @IBAction func onBottomButtonAction(_ sender: Any) {
        guard let index = pager?.currentPageIndex else { return }
        
        if let count =  pager?.orderedViewControllers.count, index < (count - 1) {
            let image = topImages[index + 1]
            
            bottomBnt.isEnabled = false
            bottomBnt.alpha = 0.3
            topImageView.image = image
            bottomBnt.setTitle(bntTexts[index + 1], for: .normal)
            if let addressVC = pager?.orderedViewControllers[index] as? AddressInfoViewController {
                let customerInfo = addressVC.getAddressInfo()
                
                self.customerName = customerInfo.name
                self.phone = customerInfo.phone
                self.email = customerInfo.email
                self.address = customerInfo.address
            } else if let payInfoVC = pager?.orderedViewControllers[index] as? PayInfoViewController {
                self.methodTransfer = payInfoVC.getTransferMethod()
                if let confirmVC = pager?.orderedViewControllers[index + 1] as? ConfirmViewController {
                    self.mailSubject = self.getMailSubject()
                    let sender = "Thông tin khách hàng\nTên: \(customerName)\nEmail: \(email)\nĐiện thoại: \(phone)\nĐịa chỉ:\(address)"
                    let shopName = savedShopInfo?["savedShopName"] ?? "NA"
                    let shopEmail = savedShopInfo?["savedShopEmail"] ?? "NA"
                    let magPhoneNumber = savedShopInfo?["savedShopManagerPhoneNumber"] ?? "NA"
                    let shopPhoneNumber = savedShopInfo?["savedShopPhoneNumber"] ?? "Hotline: 18006968"
                    let shopCellphone = savedShopInfo?["savedShopCellphone"] ?? "NA"
                    let shopAddress = savedShopInfo?["savedShopAddress"] ?? "NA"
                    let recipient = "Thông tin cửa hàng bạn chọn\nTên CH: \(shopName)\nEmail: \(shopEmail)\nĐiện thoại:\n\(magPhoneNumber)\n\(shopPhoneNumber)\n\(shopCellphone)\nĐịa chỉ:\(shopAddress)"
                    confirmVC.setData(with: sender,
                                      pay: self.methodTransfer,
                                      recipient: recipient,
                                      invoiceRef: self.mailSubject,
                                      product: items,
                                      total: total)
                }
                
            }
            
            pager?.moveNext()
        } else {
            if let vc = pager?.orderedViewControllers[index] as? ConfirmViewController, MFMailComposeViewController.canSendMail() {
                let mail = MFMailComposeViewController()
                let body = "<p>Đơn hàng: " + self.mailSubject + "</p>"
                
                mail.mailComposeDelegate = self
                mail.setToRecipients([savedShopInfo?["savedShopEmail"] ?? "cskh@adayroi.com"])
                mail.setSubject(self.mailSubject)
                mail.setMessageBody(body, isHTML: true)
                mail.addAttachmentData(vc.exportToPDF(), mimeType: "application/pdf", fileName: "donhang")
                
                present(mail, animated: true)
            } else {
                showAlert(withTitle: "", message: "Không thể gửi Email đăng ký mua hàng lúc này. Hãy kiểm tra kết nối của bạn và đảm bảo bạn đã thêm địa chỉ Email của mình trong setting")
            }
        }
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail Cancelled")
        case .saved:
            print("Mail Saved")
        case .sent:
            showToast(withMessage: "Đơn hàng của bạn đã được gửi. Chúng tôi sẽ liên hệ với bạn trong thời gian sớm nhất")
        case .failed:
            showToast(withMessage: "Có lỗi xảy ra! Hãy Kiểm tra tình trạng kết nối mạng")
        }
        
        controller.dismiss(animated: true)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func getMailSubject() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMMddHHmmss"
        let dateString = dateFormatter.string(from: Date()).uppercased()
        return ("RF" + dateString)
    }
}


extension SubmitProductViewController: BasePagesViewControllerDelegate, ProductPagerDelegate {
    func pageViewControllerWillChangePage() {
        
    }
    
    func pageViewControllerDidChange(to page: Int) {
        let image = topImages[page]
        topImageView.image = image
        bottomBnt.setTitle(bntTexts[page], for: .normal)
    }
    
    func enableBottomBnt() {
        self.bottomBnt.isEnabled = true
        bottomBnt.alpha = 1
    }
}
