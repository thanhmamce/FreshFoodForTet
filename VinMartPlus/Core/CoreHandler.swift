//
//  CoreHandler.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/17/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import Foundation

private let sharedCoreHanderInstance = CoreHandler()
class CoreHandler {
    fileprivate lazy var privateDataManager = { return DataManager() }()
    fileprivate lazy var privateEventManager = { return EventManager() }()
    
    static var shared: CoreHandler { return sharedCoreHanderInstance }
    var dataManager: DataManagerInterface { return privateDataManager }
    var eventManager: EventManagerInterface { return privateEventManager }
    
    class func initialize() {
        CoreHandler.shared.privateDataManager.initialize()
    }
}
