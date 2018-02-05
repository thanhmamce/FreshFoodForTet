//
//  LaunchScreenInteractor.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol LaunchScreenInteractorInput: class {
    
}

protocol LaunchScreenInteractorOutput: class {
    
}

class LaunchScreenInteractor: LaunchScreenInteractorInput {
    weak var output: LaunchScreenInteractorOutput?
    
}
