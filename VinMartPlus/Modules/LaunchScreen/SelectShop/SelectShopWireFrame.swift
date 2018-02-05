//
//  SelectShopWireFrame.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol SelectShopWireFrameInterface: BaseWireFrameInterface {
    
}

class SelectShopWireFrame: BaseWireFrame {
    
    func presentInterfaceForTabBar(presentWireFrame wireFrame: SelectShopWireFrame) -> UIViewController? {
        guard let viewInterface = getInterfaceFromStoryboard("SelectShop", presentInterface: "SelectShopViewController") as? SelectShopViewController else {
            return nil
        }
        
        let presenter = SelectShopPresenter()
        let interactor = SelectShopInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        return UINavigationController(rootViewController: viewInterface)
    }
    
    func presentInterfaceFromViewController(from viewController: BaseViewController, presentWireFrame wireFrame: SelectShopWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("SelectShop", presentInterface: "SelectShopViewController") as? SelectShopViewController else {
            return
        }
        
        let presenter = SelectShopPresenter()
        let interactor = SelectShopInteractor()
        
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
    
    func presentViewController(from viewController: UIViewController, presentWireFrame wireFrame: SelectShopWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("SelectShop", presentInterface: "SelectShopViewController") as? SelectShopViewController else {
            return
        }
        
        let presenter = SelectShopPresenter()
        let interactor = SelectShopInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        main_thread {
            viewController.present(viewInterface, animated: true, completion: nil)
        }
    }
}

extension SelectShopWireFrame: SelectShopWireFrameInterface {

}
