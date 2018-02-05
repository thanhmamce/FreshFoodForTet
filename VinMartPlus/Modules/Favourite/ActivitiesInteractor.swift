//
//  ActivitiesInteractor.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ActivitiesInteractorInput: class {
    func showTabBar()
}

protocol ActivitiesInteractorOutput: class {
    
}

class ActivitiesInteractor: ActivitiesInteractorInput {
    weak var output: ActivitiesInteractorOutput?
    
    func showTabBar() {
        CoreHandler.shared.eventManager.notifyListener(.willShowTabBar, params: nil)
    }
}
