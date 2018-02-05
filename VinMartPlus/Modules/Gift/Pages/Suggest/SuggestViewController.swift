//
//  SuggestViewController.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
import SwiftWebViewProgress

enum SuggestItem: Int {
    case textView
    case choiceOpt1
    case choiceOpt2
    case cancel
    case next
    
    var textValue: String {
        switch self {
        case .textView: return "Text"
        case .choiceOpt1: return "Choice 1"
        case .choiceOpt2: return "Choice 2"
        case .cancel: return "Cancel"
        case .next: return "Next"
        }
    }
}

protocol SuggestViewInterface: BaseViewInterface {
    
}

protocol SuggestSceneDelegate: class {
    func gotoNextWith(_ caption: String, content: String, choice1: String, choice2: String)
    func gotoPrevious()
}

extension SuggestSceneDelegate {
    func gotoNextWith(_ caption: String, content: String, choice1: String, choice2: String) {}
    func gotoPrevious(){}
}

class SuggestViewController: BaseViewController {
    fileprivate var presenter: SuggestPresenterInterface?
    
    @IBOutlet fileprivate weak var webView: UIWebView!
    
    private var progressView: WebViewProgressView!
    private var progressProxy: WebViewProgress!
    fileprivate var timer : Timer?
    fileprivate var refController:UIRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? SuggestPresenterInterface
        presenter?.viewDidLoad()
        
        
        progressProxy = WebViewProgress()
        webView.delegate = progressProxy
        progressProxy.webViewProxyDelegate = self
        progressProxy.progressDelegate = self
        
        let barFrame = CGRect(x: 0, y: 1, width: self.view.frame.width, height: 3.0)
        progressView = WebViewProgressView(frame: barFrame)
        progressView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.view.addSubview(progressView)
        
        self.prepareNavigationBar()
        if let url = URL(string: "http://www.vinmartplus.vn/km/1434-tet-la-phai-tuoi-km") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
//            UserDefaults.standard.register(defaults: ["UserAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/601.5.17 (KHTML, like Gecko) Version/9.1 Safari/601.5.17"])
            
            refController.bounds = CGRect(x: 0, y: 0, width: refController.bounds.size.width, height: refController.bounds.size.height)
            refController.addTarget(self, action: #selector(onRefreshWebView(_ :)), for: UIControlEvents.valueChanged)
            refController.attributedTitle = NSAttributedString(string: "Vui lòng chờ, đang tải dữ liệu...",
                                                               attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16),
                                                                            NSAttributedStringKey.foregroundColor: UIColor.orange])
            webView.scrollView.addSubview(refController)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
        deregisterNotifications()
    }
    
    fileprivate func deregisterNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    fileprivate func prepareNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    @objc func onRefreshWebView(_ refresh: UIRefreshControl){
        webView.reload()
        refController.beginRefreshing()
        self.startTimer()
    }
    
    fileprivate func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(timeout(_ :)), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func timeout(_ sender: AnyObject) {
        showCompleteView(withMessage: "Timeout")
    }
}

extension SuggestViewController: UIWebViewDelegate, WebViewProgressDelegate {
    func webViewProgress(_ webViewProgress: WebViewProgress, updateProgress progress: Float) {
        progressView.setProgress(progress, animated: true)
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        progressView.isHidden = false
        refController.isEnabled = false
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        refController.isEnabled = true
        progressView.isHidden = true
        if refController.isRefreshing {
            refController.endRefreshing()
        }
        
        if timer?.isValid == false {
            self.stopTimer()
        }
    }
}

extension SuggestViewController: SuggestViewInterface {
    
}

