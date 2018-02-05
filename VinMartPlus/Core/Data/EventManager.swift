//
//  EventManager.swift
//  Taxi Dispatching
//
//  Created by Gadapxichlo on 12/13/16.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

enum Events: Int {
    //Routing
    case requestToChatWithAnUser
    
    //Location
    case locationAuthorizationDenined
    case didUpdateLocation
    case didFailUpdateLocation
    case didExitRegion
    case didEnterRegion
    case didChangeAuthorization
    
    //Token invalid
    case tokenIsInvalid
    
    //Data
    case didLoadedData
    case willShowTabBar
}

protocol EventListenerInterface: class {
    func handleEvent(_ event: Events, params: Any?)
}

protocol EventManagerInterface {
    func addEventListener(_ listener: EventListenerInterface)
    func notifyListener(_ event: Events, params: Any?)
}

class EventManager: EventManagerInterface {
    fileprivate let weakListeners = WeakSet<EventListenerInterface>()
    
    func addEventListener(_ listener: EventListenerInterface) {
        if weakListeners.containsObject(listener) {
            return
        }
        
        weakListeners.addObject(listener)
    }
    
    func notifyListener(_ event: Events, params: Any?) {
        for listener in weakListeners {
            listener.handleEvent(event, params: params)
        }
    }
}
