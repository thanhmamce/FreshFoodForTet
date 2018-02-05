//
//  ProfilePresenter.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol ProfilePresenterInterface: BasePresenterInterface {
    
}

class ProfilePresenter: BasePresenter {
    fileprivate weak var view: ProfileViewInterface?
    fileprivate var wireFrame: ProfileWireFrameInterface?
    var interactor: ProfileInteractorInput?
    
    override init() {
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? ProfileViewInterface
        wireFrame = baseWireFrame as? ProfileWireFrameInterface
        
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
}

extension ProfilePresenter: ProfilePresenterInterface {
    
}

extension ProfilePresenter: ProfileInteractorOutput {
    
}
