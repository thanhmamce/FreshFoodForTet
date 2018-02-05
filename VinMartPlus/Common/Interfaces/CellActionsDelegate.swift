//
//  CellActionsDelegate.swift
//  LEORI
//
//  Created by KODAK on 11/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol CellActionsDelegate: class {
    func didRequestMoreAction(_ tag: Int)
    func didRequestMoreAction(at index: Int, tag: Int)
    func didClickItem(at index: Int, tag: Int)
}

extension CellActionsDelegate {
    func didRequestMoreAction(_ tag: Int) {}
    func didRequestMoreAction(at index: Int, tag: Int) {}
    func didClickItem(at index: Int, tag: Int) {}
}
