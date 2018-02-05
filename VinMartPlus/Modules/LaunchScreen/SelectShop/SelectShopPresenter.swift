//
//  SelectShopPresenter.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol SelectShopPresenterInterface: BasePresenterInterface {
    func showTabbar()
}

class SelectShopPresenter: BasePresenter {
    fileprivate weak var view: SelectShopViewInterface?
    fileprivate var wireFrame: SelectShopWireFrameInterface?
    var interactor: SelectShopInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? SelectShopViewInterface
        wireFrame = baseWireFrame as? SelectShopWireFrameInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension SelectShopPresenter: SelectShopPresenterInterface {
    func showTabbar() {
        interactor?.showTabBar()
    }
}

extension SelectShopPresenter: SelectShopInteractorOutput {
    
}
