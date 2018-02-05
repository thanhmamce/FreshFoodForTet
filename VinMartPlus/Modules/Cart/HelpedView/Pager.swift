//
//  Pager.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/20/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit

protocol ProductPagerDelegate: class {
    func enableBottomBnt()
}

class Pager: BasePagesViewController {

    weak var customPageDelegate: ProductPagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
    
    override func prepareViewControllers() {
        super.prepareViewControllers()
        
        let storyboard = UIStoryboard(name: "Profile", bundle: Bundle.main)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "AddressInfoViewController") as? AddressInfoViewController {
            viewController.delegate = self
            append(viewController)
        }
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "PayInfoViewController") as? PayInfoViewController {
            viewController.delegate = self
            append(viewController)
        }
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ConfirmViewController") as? ConfirmViewController {
            viewController.delegate = self
            append(viewController)
        }
        
        if !orderedViewControllers.isEmpty {
            self.move(to: 0)
        }
    }
}

extension Pager: ProductPagerDelegate {
    func enableBottomBnt() {
        customPageDelegate?.enableBottomBnt()
    }
}
