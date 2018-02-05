//
//  BaseMenuPresenter.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/17/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol BaseMenuPresenterInterface {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidDisappear()
    func viewDidAppeared()
}

class BaseMenuPresenter: NSObject {
    weak var baseView: BaseMenuViewInterface?
    var baseWireFrame: BaseMenuWireFrameInterface?
    
    override init() {
        super.init()
        
    }
    
}

extension BaseMenuPresenter: BaseMenuPresenterInterface {
    
    func viewDidLoad() {

    }
    
    func viewWillAppear() {
        
    }
    
    func viewDidDisappear() {
        
    }
    
    func viewDidAppeared() {
        
    }
}
