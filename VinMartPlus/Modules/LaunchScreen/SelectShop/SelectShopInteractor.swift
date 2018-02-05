//
//  SelectShopInteractor.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol SelectShopInteractorInput: class {
    func showTabBar()
}

protocol SelectShopInteractorOutput: class {
    
}

class SelectShopInteractor: SelectShopInteractorInput {
    weak var output: SelectShopInteractorOutput?
    
    func showTabBar() {
        CoreHandler.shared.eventManager.notifyListener(.willShowTabBar, params: nil)
    }
}
