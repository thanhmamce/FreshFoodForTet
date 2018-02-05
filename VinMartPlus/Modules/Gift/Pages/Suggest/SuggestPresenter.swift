//
//  SuggestPresenter.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol SuggestPresenterInterface: BasePresenterInterface {

}

class SuggestPresenter: BasePresenter {
    fileprivate weak var view: SuggestViewInterface?
    fileprivate var wireFrame: SuggestWireFrameInterface?
    var interactor: SuggestInteractorInput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? SuggestViewInterface
        wireFrame = baseWireFrame as? SuggestWireFrameInterface
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}

extension SuggestPresenter: SuggestPresenterInterface {
    
}

extension SuggestPresenter: SuggestInteractorOutput {
    
}
