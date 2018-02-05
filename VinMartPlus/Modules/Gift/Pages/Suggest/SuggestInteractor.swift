//
//  SuggestInteractor.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol SuggestInteractorInput: class {
    
}

protocol SuggestInteractorOutput: class {
    
}

class SuggestInteractor: SuggestInteractorInput {
    weak var output: SuggestInteractorOutput?
    
}
