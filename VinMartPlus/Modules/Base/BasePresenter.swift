//
//  BasePresenter.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol BasePresenterInterface: class {
    func viewDidLoad()
    func viewWillAppear()
    func viewWillDisappear()
    func viewDidDisappear()
    func viewDidAppeared()
}

class BasePresenter: NSObject, EventListenerInterface {
    weak var baseView: BaseViewInterface?
    var baseWireFrame: BaseWireFrameInterface?
    
    override init() {
        super.init()
        
        CoreHandler.shared.eventManager.addEventListener(self)
    }
    
    func handleEvent(_ event: Events, params: Any?) {
        
    }
//}
//
//extension BasePresenter: BasePresenterInterface {
//    
    func viewDidLoad() {
        
    }
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func viewDidDisappear() {

    }
    
    func viewDidAppeared() {
        
    }
}
