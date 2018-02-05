//
//  PopOverViewDelegate.swift
//  LEORI
//
//  Created by thanh nguyen on 11/30/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol PopOverViewDelegate: class {
    func didSelectedOption(at row: Int, value: String)
}

extension PopOverViewDelegate {
    func didSelectedOption(at row: Int, value: String) {}
}
