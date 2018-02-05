//
//  ProfileWireFrame.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol ProfileWireFrameInterface: BaseWireFrameInterface {
    
}

class ProfileWireFrame: BaseWireFrame {

    func presentInterfaceForTabBar(presentWireFrame wireFrame: ProfileWireFrame) -> UIViewController? {
        guard let viewInterface = getInterfaceFromStoryboard("Profile", presentInterface: "ProfileViewController") as? ProfileViewController else {
            return nil
        }
        
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        
        viewInterface.basePresenter = presenter
        
        presenter.baseView = viewInterface
        presenter.baseWireFrame = wireFrame
        presenter.interactor = interactor
        
        basePresentedViewController = viewInterface
        
        interactor.output = presenter
        
        return UINavigationController(rootViewController: viewInterface)
    }
    
    func presentInterfaceFromViewController(from viewController: BaseViewController, presentWireFrame wireFrame: ProfileWireFrame) {
        guard let viewInterface = getInterfaceFromStoryboard("Profile", presentInterface: "ProfileViewController") as? ProfileViewController else {
            return
        }
        
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        
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

extension ProfileWireFrame: ProfileWireFrameInterface {
    
}
