//
//  ConfirmViewController.swift
//  Print2PDF
//
//  Created by Gabriel Theodoropoulos on 14/06/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit
import MessageUI


class ConfirmViewController: BaseViewController, UIWebViewDelegate {
    @IBOutlet fileprivate weak var webView: UIWebView!
    @IBOutlet fileprivate weak var indicator: UIActivityIndicatorView!
    
    weak var delegate: ProductPagerDelegate?

    var invoiceInfo: [String: AnyObject]!
    
    fileprivate var invoiceComposer: InvoiceComposer!
    
    fileprivate var HTMLContent: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        indicator.startAnimating()
        indicator.isHidden = false
        webView.loadHTMLString(HTMLContent, baseURL: NSURL(string: invoiceComposer.pathToInvoiceHTMLTemplate!)! as URL)
        delegate?.enableBottomBnt()
    }
    
    
    func exportToPDF() -> Data {
        if let data = invoiceComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent) as Data? {
            return data
        }
        
        return Data()
    }
    
    func setData(with sender: String,
                 pay: String,
                 recipient: String,
                 invoiceRef: String,
                 product: [[String: String]],
                 total: Int) {
        
        invoiceComposer = InvoiceComposer()
        if let invoiceHTML = invoiceComposer.renderInvoice(invoiceNumber: invoiceRef,
                                                           payMethod: pay,
                                                           senderInfo: sender,
                                                           recipientInfo: recipient,
                                                           items: product,
                                                           totalAmount: "\(total)") {
            
            HTMLContent = invoiceHTML
        }
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
        indicator.isHidden = true
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicator.stopAnimating()
        indicator.isHidden = true
        showAlert(withTitle: "", message: "Có lỗi xảy ra! Không thể tạo đơn hàng của bạn. Hãy kiểm tra lại đơn hàng")
    }
}
