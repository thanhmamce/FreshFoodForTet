//
//  TabBarController.swift
//  KekiruDict
//
//  Created by KODAK on 3/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol TabBarViewInterface: BaseViewInterface {
    func selectMessageTab()
}

class TabBarController: BaseTabBarController {
    fileprivate var presenter: TabBarPresenterInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? TabBarPresenterInterface
        presenter?.viewDidLoad()
        
        initializeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
    
    fileprivate func initializeView() {
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.tintColor = UIColor(0xe71b28)
        self.tabBar.clipsToBounds = true
    }
}

extension TabBarController: TabBarViewInterface {
    
    func selectMessageTab() {
        guard let controllers = viewControllers, viewControllers?.count == 5 else { return }
        
        self.selectedIndex = (controllers.count-1)-1
    }

}
