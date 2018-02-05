//
//  BaseWireFrame.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol BaseWireFrameInterface {
    func dismissInterface()
    func popInterface()
    func presentLaunchScreenViewInterface()
}

class BaseWireFrame: NSObject {
    weak var basePresentedViewController: UIViewController?
    
    func getInterfaceFromStoryboard(_ name: String, presentInterface identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: name, bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier) // as! BaseViewController
        
        return viewController
    }
    
    func getInterfaceFromStoryboardEx(_ name: String, presentInterface identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: name, bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier) // as! BaseViewController
        
        return viewController
    }
    
    func getInterfaceFromStoryboardForTableView(_ name: String, presentInterface identifier: String) -> UIViewController {
        let storyBoard = UIStoryboard(name: name, bundle: Bundle.main)
        let viewController = storyBoard.instantiateViewController(withIdentifier: identifier) // as! BaseTableViewController
        
        return viewController
    }
}

extension BaseWireFrame: BaseWireFrameInterface {
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
extension BaseWireFrame: UIViewControllerTransitioningDelegate {
    
}
