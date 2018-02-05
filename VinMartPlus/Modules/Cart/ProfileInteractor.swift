//
//  ProfileInteractor.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ProfileInteractorInput: class {
    
}

protocol ProfileInteractorOutput: class {
    
}

class ProfileInteractor: ProfileInteractorInput {
    weak var output: ProfileInteractorOutput?
    
}
