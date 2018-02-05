//
//  HomePagePresenter.swift
//  LEORI
//
//  Created by KODAK on 11/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol HomePagePresenterInterface: BasePresenterInterface {

}

class HomePagePresenter: BasePresenter {
    fileprivate weak var view: HomePageViewInterface?
    var interactor: HomePageInteractorInput?
    
    fileprivate var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? HomePageViewInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
}

extension HomePagePresenter: HomePagePresenterInterface {
    
}

extension HomePagePresenter: HomePageInteractorOutput {
    
}
