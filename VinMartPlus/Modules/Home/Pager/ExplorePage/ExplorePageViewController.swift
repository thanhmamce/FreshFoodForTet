//
//  ExplorePageViewController.swift
//  LEORI
//
//  Created by KODAK on 11/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol ExplorePageViewInterface: BaseViewInterface {
    
}

class ExplorePageViewController: BaseViewController {
    fileprivate var presenter: ExplorePagePresenterInterface?
    weak var delegate: HomePagerDelegate?
    fileprivate let defaultCellIdentifier = "DefaultCellIdentifier"
    
    override func viewDidInit() {
        let interactor = ExplorePageInteractor()
        let presenter = ExplorePagePresenter()
        
        basePresenter = presenter
        
        presenter.baseView = self
        presenter.interactor = interactor
        
        interactor.output = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? ExplorePagePresenterInterface
        presenter?.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
    
}

extension ExplorePageViewController: ExplorePageViewInterface {
    
}

extension ExplorePageViewController: CellActionsDelegate {
    
}
