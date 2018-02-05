//
//  LaunchScreenWireFrame.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol LaunchScreenWireFrameInterface: BaseWireFrameInterface {
    func showHome()
    func showTabBar()
    func showSelectAddress()
}

class LaunchScreenWireFrame: BaseWireFrame {
    lazy fileprivate var homeWireFrame = HomeWireFrame()
    fileprivate lazy var tabbarWireFrame = TabBarWireFrame()
    fileprivate lazy var selectShopWireFrame = SelectShopWireFrame()

    func presentInterfaceFromWindow(_ window: UIWindow, presentWireFrame wireFrame: LaunchScreenWireFrame) {
        let presenter = LaunchScreenPresenter()
        let interactor = LaunchScreenInteractor()
        print("thanhnguyen: add listener")
        if let viewInterface = getInterfaceFromStoryboard("LaunchScreen", presentInterface: "LaunchScreenViewController") as? LaunchScreenViewController {
            viewInterface.basePresenter = presenter
            
            presenter.baseView = viewInterface
            presenter.baseWireFrame = wireFrame
            presenter.interactor = interactor
            
            interactor.output = presenter
            
            basePresentedViewController = viewInterface
            
            window.rootViewController = viewInterface
        }
    }
    
    func presentInterfaceFromViewController(from viewController: UIViewController, presentWireFrame wireFrame: LaunchScreenWireFrame) {
        let viewInterface = getInterfaceFromStoryboard("LaunchScreen", presentInterface: "LaunchScreenViewController") as! LaunchScreenViewController
        let presenter = LaunchScreenPresenter()
        let interactor = LaunchScreenInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        main_thread {
            viewController.navigationController?.pushViewController(viewInterface, animated: true)
        }
    }
}

extension LaunchScreenWireFrame: LaunchScreenWireFrameInterface {
    
    func showHome() {
        homeWireFrame.presentInterfaceAsRootViewController(presentWireFrame: homeWireFrame)
    }
    
    func showTabBar() {
        tabbarWireFrame.presentInterfaceAsRootViewController(presentWireFrame: tabbarWireFrame)
    }
    
    func showSelectAddress() {
        if let presetedVC = self.basePresentedViewController {
            selectShopWireFrame.presentViewController(from: presetedVC,
                                                      presentWireFrame: selectShopWireFrame)
        }
    }
}
