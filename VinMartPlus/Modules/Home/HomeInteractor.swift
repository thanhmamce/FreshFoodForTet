//
//  HomeInteractor.swift
//  LEORI
//
//  Created by Gadapxichlo on 7/26/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol HomeInteractorInput: class {
    func getProducts() -> [product]
}

protocol HomeInteractorOutput: class {
    
}

class HomeInteractor: HomeInteractorInput {
    weak var output: HomeInteractorOutput?
    
    func getProducts() -> [product] {
        return CoreHandler.shared.dataManager.getProducts()
    }
}
