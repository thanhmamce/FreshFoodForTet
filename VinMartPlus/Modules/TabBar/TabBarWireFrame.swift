//
//  TabBarWireFrame.swift
//  LEORI
//
//  Created by KODAK on 3/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

//fileprivate let sharedInstance = TabBarWireFrame()

protocol TabBarWireFrameInterface: BaseWireFrameInterface {
    func presentAsRoot()
}

class TabBarWireFrame: BaseWireFrame {
    
//    static var shared: TabBarWireFrameInterface {
//        return sharedInstance
//    }
    
    fileprivate lazy var homeWireFrame = HomeWireFrame()
    fileprivate lazy var activitiesWireFrame = ActivitiesWireFrame()
    fileprivate lazy var suggestWireFrame = SuggestWireFrame()
    fileprivate lazy var profileWireFrame = ProfileWireFrame()
    
    func presentInterfaceAsRootViewController(presentWireFrame wireFrame: TabBarWireFrame) {
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        guard let viewInterface = getInterfaceFromStoryboardEx("TabBar", presentInterface:"TabBarController") as? TabBarController else  {
            return
        }
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        main_thread {
            if let viewControllers = self.prepareTabs() {
                viewInterface.viewControllers = viewControllers
            }
            
            UIApplication.shared.keyWindow?.rootViewController = viewInterface
        }
    }
    
    fileprivate func prepareTabs() -> [UIViewController]? {
        var viewControllerArray = [UIViewController]()
        
        if let viewController = homeWireFrame.presentInterfaceForTabBar(presentWireFrame: homeWireFrame) {
            let item = UITabBarItem(title: "Trang chủ",
                                    image: UIImage(named: "home")?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: nil)
//            item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
            viewController.tabBarItem = item
            viewControllerArray.append(viewController)
        }
        
        if let pageViewController = suggestWireFrame.presentInterfaceForTabBar(presentWireFrame: suggestWireFrame) {
            let item = UITabBarItem(title: "Khuyến mãi",
                                    image: UIImage(named: "gift")?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: nil)

            pageViewController.tabBarItem = item
            viewControllerArray.append(pageViewController)
        }
        
        if let viewController = profileWireFrame.presentInterfaceForTabBar(presentWireFrame: profileWireFrame) {
            let item = UITabBarItem(title: "Giỏ hàng",
                                    image: UIImage(named: "card")?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: nil)
            
            viewController.tabBarItem = item
            viewControllerArray.append(viewController)
        }
        
        
        if let viewController = activitiesWireFrame.presentInterfaceForTabBar(presentWireFrame: activitiesWireFrame) {
            let item = UITabBarItem(title: "Cửa hàng",
                                    image: UIImage(named: "location")?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: nil)
            
            viewController.tabBarItem = item
            viewControllerArray.append(viewController)
        }
        
        if viewControllerArray.isEmpty {
            return nil
        }
        
        return viewControllerArray
    }
}

extension TabBarWireFrame: TabBarWireFrameInterface {
    
    func presentAsRoot() {
        if let viewInterface = basePresentedViewController {
            main_thread {
                UIApplication.shared.keyWindow?.rootViewController = viewInterface
            }
            return
        }
        
        guard let viewInterface = getInterfaceFromStoryboardEx("TabBar", presentInterface:"TabBarController") as? TabBarController else  {
            return
        }
        
        let presenter = TabBarPresenter()
        let interactor = TabBarInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = self
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        main_thread {
            if let viewControllers = self.prepareTabs() {
                viewInterface.viewControllers = viewControllers
            }
            
            UIApplication.shared.keyWindow?.rootViewController = viewInterface
        }
    }
}
