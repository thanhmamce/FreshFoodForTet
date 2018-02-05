//
//  ExploreSearchPagePresenter.swift
//  LEORI
//
//  Created by KODAK on 11/27/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ExploreSearchPagePresenterInterface: BasePresenterInterface {

}

class ExploreSearchPagePresenter: BasePresenter {
    fileprivate weak var view: ExploreSearchPageViewInterface?
    var interactor: ExploreSearchPageInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? ExploreSearchPageViewInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension ExploreSearchPagePresenter: ExploreSearchPagePresenterInterface {
    
}

extension ExploreSearchPagePresenter: ExploreSearchPageInteractorOutput {
    
}
