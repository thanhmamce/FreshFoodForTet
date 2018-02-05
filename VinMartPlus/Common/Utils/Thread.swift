//
//  Thread.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

func synchronized(_ lock: Any?, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}

func main_thread(_ closure: @escaping () -> ()) {
    DispatchQueue.main.async(execute: {
        closure()
    })
}

func background_thread(_ closure: @escaping () -> ()) {
    DispatchQueue.global(qos: .background).async(execute: {
        closure()
    })
}
