//
//  SuggestWireFrame.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol SuggestWireFrameInterface: BaseWireFrameInterface {
    
}

class SuggestWireFrame: BaseWireFrame {
    func presentInterfaceForTabBar(presentWireFrame wireFrame: SuggestWireFrame) -> UIViewController? {
        guard let viewInterface = getInterfaceFromStoryboard("Suggest", presentInterface: "SuggestViewController") as? SuggestViewController else {
            return nil
        }
        
        let presenter = SuggestPresenter()
        let interactor = SuggestInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        return UINavigationController(rootViewController: viewInterface)
    }
    
    func presentInterfaceFromViewController(from viewController: BaseViewController, presentWireFrame wireFrame: SuggestWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("Suggest", presentInterface: "SuggestViewController") as? SuggestViewController else {
            return
        }
        
        let presenter = SuggestPresenter()
        let interactor = SuggestInteractor()
        
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

extension SuggestWireFrame: SuggestWireFrameInterface {

}
