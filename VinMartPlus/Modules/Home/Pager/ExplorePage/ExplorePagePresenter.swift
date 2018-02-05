//
//  ExplorePagePresenter.swift
//  LEORI
//
//  Created by KODAK on 11/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ExplorePagePresenterInterface: BasePresenterInterface {
    
}

class ExplorePagePresenter: BasePresenter {
    fileprivate weak var view: ExplorePageViewInterface?
    var interactor: ExplorePageInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? ExplorePageViewInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension ExplorePagePresenter: ExplorePagePresenterInterface {
    
}

extension ExplorePagePresenter: ExplorePageInteractorOutput {
    
}
