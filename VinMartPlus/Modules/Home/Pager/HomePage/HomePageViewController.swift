//
//  HomePageViewController.swift
//  LEORI
//
//  Created by KODAK on 11/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol HomePageViewInterface: BaseViewInterface {
    
}

class HomePageViewController: BaseViewController {
    fileprivate var presenter: HomePagePresenterInterface?
    weak var delegate: HomePagerDelegate?
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        return UIActivityIndicatorView(activityIndicatorStyle: .gray)
    }()
    
    
    override func viewDidInit() {
        let interactor = HomePageInteractor()
        let presenter = HomePagePresenter()
        
        basePresenter = presenter
        
        presenter.baseView = self
        presenter.interactor = interactor
        
        interactor.output = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? HomePagePresenterInterface
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

extension HomePageViewController: HomePageViewInterface {
    
}
