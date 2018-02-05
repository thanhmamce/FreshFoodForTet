//
//  BaseViewController.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

protocol BaseViewInterface: class {
    func showLoadingView()
    func showLoadingView(withMessage message: String?)
    func showCompleteView()
    func showCompleteView(withMessage message: String?)
    func hideLoadingView()
    func hideLoadingView(onCompletion: (() -> Void)?)
    func setLoadingMessage(_ message: String?)
    func showAlert(withTitle title:String?, message mes: String?)
    func showAlert(withTitle title:String?, message mes: String?, completeHandler handle: @escaping (AnyObject?) -> Void)
    func showAlertConfirm(withTitle title: String?, meesage mes: String?, didCancel cancleClosure: @escaping (AnyObject?) -> Void, didConfirm comfirmClosure: @escaping (AnyObject?) -> Void)
    func showToast(withMessage message: String)
}

extension BaseViewInterface {
    func showLoadingView() {}
    func showLoadingView(withMessage message: String?) {}
    func showCompleteView() {}
    func showCompleteView(withMessage message: String?) {}
    func hideLoadingView() {}
    func hideLoadingView(onCompletion: (() -> Void)?) {}
    func setLoadingMessage(_ message: String?) {}
    func showAlert(withTitle title:String?, message mes: String?) {}
    func showAlert(withTitle title:String?, message mes: String?, completeHandler handle: @escaping (AnyObject?) -> Void) {}
    func showAlertConfirm(withTitle title: String?, meesage mes: String?, didCancel cancleClosure: @escaping (AnyObject?) -> Void, didConfirm comfirmClosure: @escaping (AnyObject?) -> Void) {}
    func showToast(withMessage message: String) {}
}

class BaseViewController: UIViewController {
    var basePresenter: BasePresenterInterface?
    
    fileprivate lazy var progressHUD: MBProgressHUD = {
        let progressHUD = MBProgressHUD(view: self.view)
        progressHUD.customView = UIImageView(image: UIImage(named: "ic_checkmark"))
        progressHUD.label.text = "Loading..."
        progressHUD.mode = .indeterminate
        progressHUD.removeFromSuperViewOnHide = true
        return progressHUD
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.viewDidInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.viewDidInit()
    }
    
    func viewDidInit() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        print("didReceiveMemoryWarning")
        super.didReceiveMemoryWarning()
    }
    
    func showLoadingView() {
        self.showLoadingView(withMessage: nil)
    }
    
    func showLoadingView(withMessage message: String?) {
        main_thread {
            self.progressHUD.mode = .indeterminate
            self.progressHUD.label.text = message ?? "Loading"
            if self.progressHUD.superview == nil {
                self.view.addSubview(self.progressHUD)
                self.progressHUD.show(animated: true)
            }
        }
    }
    
    func showCompleteView() {
        self.showCompleteView(withMessage: nil)
    }
    
    func showCompleteView(withMessage message: String?) {
        main_thread {
            self.progressHUD.mode = .customView
            self.progressHUD.label.text = message ?? "Completed"
            if self.progressHUD.superview == nil {
                self.view.addSubview(self.progressHUD)
                self.progressHUD.show(animated: true)
            }
        }
    }
    
    func hideLoadingView() {
        self.hideLoadingView(onCompletion: nil)
    }
    
    func hideLoadingView(onCompletion: (() -> Void)?) {
        main_thread {
            self.progressHUD.hide(animated: true)
            self.progressHUD.removeFromSuperview()
            background_thread {
                onCompletion?()
            }
        }
    }
    
    func setLoadingMessage(_ message: String?) {
        main_thread {
            self.progressHUD.label.text = message
        }
    }
    
    func showAlert(withTitle title:String?, message mes: String?) {
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        main_thread {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlert(withTitle title:String?, message mes: String?, completeHandler handle: @escaping (AnyObject?) -> Void) {
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            handle(action as AnyObject?)
        }))
            
        main_thread {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showAlertConfirm(withTitle title: String?, meesage mes: String?, didCancel cancleClosure: @escaping (AnyObject?) -> Void, didConfirm comfirmClosure: @escaping (AnyObject?) -> Void) {
        let alert = UIAlertController(title: title, message: mes, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
            cancleClosure(self)
        }))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            comfirmClosure(self)
        }))
        
        main_thread {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showToast(withMessage message: String) {
        self.view.makeToast(message, duration: 2.0, position: .center)
    }
}

extension BaseViewController: BaseViewInterface {
    
}
