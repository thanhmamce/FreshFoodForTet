//
//  BaseMenuItemViewController.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/17/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class BaseMenuItemViewController: BaseViewController {
    fileprivate lazy var sidebarButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(named: "navigation_menu"),
                               style: .plain,
                               target: self,
                               action: #selector(onSidebarButtonClicked(_:)))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.leftBarButtonItem = self.sidebarButton
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @objc fileprivate func onSidebarButtonClicked(_ sender: AnyObject) {
//        self.so_containerViewController?.isSideViewControllerPresented = true
//        CoreHandler.shared.eventManager.notifyListener(.menuDidShowOrHide, params: nil)
    }
}
