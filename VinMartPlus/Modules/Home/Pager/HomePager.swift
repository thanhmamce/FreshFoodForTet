//
//  HomePager.swift
//  LEORI
//
//  Created by KODAK on 11/13/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol HomePagerDelegate: class {
    func didClickOnPoll(_ id: String)
}

class HomePager: BasePagesViewController {
    
    weak var customPageDelegate: HomePagerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
    }
    
    override func prepareViewControllers() {
        super.prepareViewControllers()
        
        let storyboard = UIStoryboard(name: "Home", bundle: Bundle.main)
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ExploreSearchPageViewController") as? ExploreSearchPageViewController {
            append(viewController)
        }
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "ExplorePageViewController") as? ExplorePageViewController {
            viewController.delegate = self
            append(viewController)
        }
        
        if let viewController = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
            viewController.delegate = self
            append(viewController)
        }
        
        if !orderedViewControllers.isEmpty {
            self.move(to: 0)
        }
    }
}

extension HomePager: HomePagerDelegate {
    func didClickOnPoll(_ id: String) {
        customPageDelegate?.didClickOnPoll(id)
    }
}
