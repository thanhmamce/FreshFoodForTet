//
//  Addresses.swift
//  LEORI
//
//  Created by KODAK on 11/8/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

func address(o: UnsafeRawPointer) -> Int {
    return Int(bitPattern: o)
}

func addressHeap<T: AnyObject>(o: T) -> Int {
    return unsafeBitCast(o, to: Int.self)
}
