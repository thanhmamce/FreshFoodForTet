//
//  TabBarInteractor.swift
//  LEORI
//
//  Created by KODAK on 3/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol TabBarInteractorInput: class {

}

protocol TabBarInteractorOutput: class {
    
}

class TabBarInteractor: TabBarInteractorInput {
    weak var output: TabBarInteractorOutput?
}
