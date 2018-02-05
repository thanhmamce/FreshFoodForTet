//
//  ActivitiesWireFrame.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol ActivitiesWireFrameInterface: BaseWireFrameInterface {
    
}

class ActivitiesWireFrame: BaseWireFrame {
    
    func presentInterfaceForTabBar(presentWireFrame wireFrame: ActivitiesWireFrame) -> UIViewController? {
        guard let viewInterface = getInterfaceFromStoryboard("Activities", presentInterface: "ActivitiesViewController") as? ActivitiesViewController else {
            return nil
        }
        
        let presenter = ActivitiesPresenter()
        let interactor = ActivitiesInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        return UINavigationController(rootViewController: viewInterface)
    }
    
    func presentInterfaceFromViewController(from viewController: BaseViewController, presentWireFrame wireFrame: ActivitiesWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("Activities", presentInterface: "ActivitiesViewController") as? ActivitiesViewController else {
            return
        }
        
        let presenter = ActivitiesPresenter()
        let interactor = ActivitiesInteractor()
        
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
    
    func presentViewController(from viewController: UIViewController, presentWireFrame wireFrame: ActivitiesWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("Activities", presentInterface: "ActivitiesViewController") as? ActivitiesViewController else {
            return
        }
        
        let presenter = ActivitiesPresenter()
        let interactor = ActivitiesInteractor()
        
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

extension ActivitiesWireFrame: ActivitiesWireFrameInterface {

}
