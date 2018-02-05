//
//  TabBarPresenter.swift
//  LEORI
//
//  Created by KODAK on 3/14/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol TabBarPresenterInterface: BasePresenterInterface {

}

class TabBarPresenter: BasePresenter {
    fileprivate weak var view: TabBarViewInterface?
    fileprivate var wireFrame: TabBarWireFrameInterface?
    var interactor: TabBarInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? TabBarViewInterface
        wireFrame = baseWireFrame as? TabBarWireFrameInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
}

extension TabBarPresenter: TabBarPresenterInterface {
    
}

extension TabBarPresenter: TabBarInteractorOutput {
    
}
