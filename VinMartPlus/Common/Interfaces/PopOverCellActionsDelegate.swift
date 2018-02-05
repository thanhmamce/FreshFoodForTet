//
//  PopOverCellActionsDelegate.swift
//  LEORI
//
//  Created by thanh nguyen on 11/30/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol PopOverCellActionsDelegate: class {
    func didClickSendMessage()
    func didClickBlock()
    func didClickFollow()
}

extension PopOverCellActionsDelegate {
    func didClickSendMessage() {}
    func didClickBlock() {}
    func didClickFollow() {}
}
