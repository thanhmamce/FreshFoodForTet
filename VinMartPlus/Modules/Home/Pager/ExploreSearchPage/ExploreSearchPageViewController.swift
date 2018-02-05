//
//  ExploreSearchPageViewController.swift
//  LEORI
//
//  Created by KODAK on 11/27/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol ExploreSearchPageViewInterface: BaseViewInterface {
    
}

class ExploreSearchPageViewController: BaseViewController {
    fileprivate var presenter: ExploreSearchPagePresenterInterface?

    override func viewDidInit() {
        let interactor = ExploreSearchPageInteractor()
        let presenter = ExploreSearchPagePresenter()
        
        basePresenter = presenter
        
        presenter.baseView = self
        presenter.interactor = interactor
        
        interactor.output = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? ExploreSearchPagePresenterInterface
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        presenter?.viewDidAppeared()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
}

extension ExploreSearchPageViewController: ExploreSearchPageViewInterface {
    
}
