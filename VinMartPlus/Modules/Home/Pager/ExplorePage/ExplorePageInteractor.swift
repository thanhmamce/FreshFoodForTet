//
//  ExplorePageInteractor.swift
//  LEORI
//
//  Created by KODAK on 11/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ExplorePageInteractorInput: class {
    
}

protocol ExplorePageInteractorOutput: class {
    
}

class ExplorePageInteractor: ExplorePageInteractorInput {
    weak var output: ExplorePageInteractorOutput?
    
    init() {
        
    }
    
}

