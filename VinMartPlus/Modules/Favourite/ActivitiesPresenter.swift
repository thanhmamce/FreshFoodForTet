//
//  ActivitiesPresenter.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ActivitiesPresenterInterface: BasePresenterInterface {
    func showTabbar()
}

class ActivitiesPresenter: BasePresenter {
    fileprivate weak var view: ActivitiesViewInterface?
    fileprivate var wireFrame: ActivitiesWireFrameInterface?
    var interactor: ActivitiesInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? ActivitiesViewInterface
        wireFrame = baseWireFrame as? ActivitiesWireFrameInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension ActivitiesPresenter: ActivitiesPresenterInterface {
    func showTabbar() {
        interactor?.showTabBar()
    }
}

extension ActivitiesPresenter: ActivitiesInteractorOutput {
    
}
