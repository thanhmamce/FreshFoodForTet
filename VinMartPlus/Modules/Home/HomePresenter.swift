//
//  HomePresenter.swift
//  LEORI
//
//  Created by Gadapxichlo on 7/26/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol HomePresenterInterface: BasePresenterInterface {
    func getProducts() -> [product]
}

class HomePresenter: BasePresenter {
    fileprivate weak var view: HomeViewInterface?
    fileprivate var wireFrame: HomeWireFrameInterface?
    var interactor: HomeInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? HomeViewInterface
        wireFrame = baseWireFrame as? HomeWireFrameInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension HomePresenter: HomePresenterInterface {
    func getProducts() -> [product] {
        return interactor?.getProducts() ?? []
    }
}

extension HomePresenter: HomeInteractorOutput {
    
}
