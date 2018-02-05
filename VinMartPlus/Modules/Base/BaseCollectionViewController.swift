//
//  BaseCollectionViewController.swift
//  LEORI
//
//  Created by KODAK on 10/4/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol BaseCollectionViewInterface: class {
    
}

class BaseCollectionViewController: UICollectionViewController {
    var basePresenter: BasePresenterInterface?
    
    fileprivate lazy var progressHUD: MBProgressHUD = {
        let progressHUD = MBProgressHUD(view: self.view)
        progressHUD.label.text = "Loading..."
        progressHUD.mode = .indeterminate
        progressHUD.removeFromSuperViewOnHide = true
        return progressHUD
    }()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        self.viewDidInit()
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
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    @objc fileprivate func onSidebarButtonClicked(_ sender: AnyObject) {
        
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
        self.showLoadingView(withMessage: "Loading")
    }
    
    func showLoadingView(withMessage message: String?) {
        main_thread({
            self.progressHUD.label.text = message
            self.view.superview?.addSubview(self.progressHUD)
            self.progressHUD.show(animated: true)
        })
    }
    
    func hideLoadingView() {
        self.hideLoadingView(onCompletion: nil)
    }
    
    func hideLoadingView(onCompletion: (() -> Void)?) {
        main_thread({
            self.progressHUD.hide(animated: true)
            self.progressHUD.removeFromSuperview()
        })
        
        onCompletion?()
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
    
    func showLocationServiceDeniedAlert(didSuccess closureSuccess: @escaping  (() -> Void), didFail closureFail: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "Location services are off", message: "To use background location you must select 'While using in the app' in the Location Services Settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {(action) in
            closureFail()
        }))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (action) in
            guard let settingsURL = URL(string: UIApplicationOpenSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.openURL(settingsURL)
            }
            closureSuccess()
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
}

extension BaseCollectionViewController: BaseCollectionViewInterface {
    
}

