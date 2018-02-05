//
//  HomeWireFrame.swift
//  LEORI
//
//  Created by Gadapxichlo on 7/26/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol HomeWireFrameInterface: BaseWireFrameInterface {
    
}

class HomeWireFrame: BaseWireFrame {
    
    func presentInterfaceForTabBar(presentWireFrame wireFrame: HomeWireFrame) -> UIViewController? {
        guard let viewInterface = getInterfaceFromStoryboard("Home", presentInterface: "HomeViewController") as? HomeViewController else {
            return nil
        }
        
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        return UINavigationController(rootViewController: viewInterface)
    }
    
    func presentInterfaceAsRootViewController(presentWireFrame wireFrame: HomeWireFrame) {
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        guard let viewInterface = getInterfaceFromStoryboard("Home", presentInterface:
            "HomeViewController") as? HomeViewController else  {
                return
        }
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        main_thread {
            UIApplication.shared.keyWindow?.rootViewController = viewInterface
        }
    }
    
    func presentInterfaceFromViewController(from viewController: BaseViewController, presentWireFrame wireFrame: HomeWireFrame) {
        let viewInterface = getInterfaceFromStoryboard("Home", presentInterface: "HomeViewController") as! HomeViewController
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        
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

extension HomeWireFrame: HomeWireFrameInterface {
    
}
