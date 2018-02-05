//
//  BaseMenuViewController.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/17/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol BaseMenuViewInterface: class {
    
}

class BaseMenuViewController: UIViewController {
    internal lazy var baseNavigationController: UINavigationController = {
        let controller = UINavigationController()
        controller.navigationBar.barStyle = .black
        controller.navigationBar.tintColor = UIColor.white
        return controller
    }()
    
    var basePresenter: BaseMenuPresenterInterface?
    
    override var prefersStatusBarHidden: Bool {
        return true
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
}

extension BaseMenuViewController: BaseMenuViewInterface {
    
}
