//
//  LaunchScreenViewController.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol LaunchScreenViewInterface: BaseViewInterface {
    
}

class LaunchScreenViewController: BaseViewController {
    fileprivate var presenter: LaunchScreenPresenterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? LaunchScreenPresenterInterface
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
}

extension LaunchScreenViewController: LaunchScreenViewInterface {
    
}
