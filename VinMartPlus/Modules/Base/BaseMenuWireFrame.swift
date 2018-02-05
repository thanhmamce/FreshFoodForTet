//
//  BaseMenuWireFrame.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/17/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol BaseMenuWireFrameInterface {
    func dismissInterface()
    func popInterface()
    func presentLaunchScreenViewInterface()
}

class BaseMenuWireFrame: NSObject {
    weak var basePresentedViewController: BaseMenuViewController?
    
    func getInterfaceFromStoryboard(_ name: String, presentInterface identifier: String) -> BaseMenuViewController {
        let storyBoard = UIStoryboard(name: name, bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier) as! BaseMenuViewController
        
        return viewController
    }
    
    func getInterfaceFromStoryboardForTableView(_ name: String, presentInterface identifier: String) -> BaseTableViewController {
        let storyBoard = UIStoryboard(name: name, bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier) as! BaseTableViewController
        
        return viewController
    }
}

extension BaseMenuWireFrame: BaseMenuWireFrameInterface {
    func dismissInterface() {
        main_thread {
            self.basePresentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
    func popInterface() {
        main_thread {
            _ = self.basePresentedViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    func presentLaunchScreenViewInterface() {
        let launchScreenWireFrame = LaunchScreenWireFrame()
        
        if let presentedViewController = basePresentedViewController {
            main_thread {
                launchScreenWireFrame.presentInterfaceFromViewController(from: presentedViewController,
                                                                         presentWireFrame: launchScreenWireFrame)
            }
        }
    }
}

// Animation
extension BaseMenuWireFrame: UIViewControllerTransitioningDelegate {
    
}
