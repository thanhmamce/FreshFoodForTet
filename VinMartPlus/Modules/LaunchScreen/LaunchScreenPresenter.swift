//
//  LaunchScreenPresenter.swift
//  Taxi Dispatching
//
//  Created by KODAK on 2/16/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

protocol LaunchScreenPresenterInterface: BasePresenterInterface {

}

class LaunchScreenPresenter: BasePresenter {
    fileprivate weak var view: LaunchScreenViewInterface?
    fileprivate var wireFrame: LaunchScreenWireFrameInterface?
    var interactor: LaunchScreenInteractorInput?
    
    fileprivate var isSelectingShop: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = baseView as? LaunchScreenViewInterface
        wireFrame = baseWireFrame as? LaunchScreenWireFrameInterface
       
        if CoreHandler.shared.dataManager.isDataAvaiable() {
            if let _ = UserDefaults.standard.object(forKey: "vmpShopInfo") as? [String: String] {
                wireFrame?.showTabBar()
            } else {
                if isSelectingShop == false {
                    isSelectingShop = true
                    wireFrame?.showSelectAddress()
                }
            }
        } else {
            view?.showLoadingView()
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
    
    override func handleEvent(_ event: Events, params: Any?) {
        if event == .didLoadedData && isSelectingShop == false {
            main_thread {
                self.view?.hideLoadingView()
                
                if let _ = params as? NSError {
                    self.view?.showAlert(withTitle: "Error", message: "Không thể tải dữ liệu. Hãy kiểm tra tình trạng kết nối của bạn")
                } else {
                    if let _ = UserDefaults.standard.object(forKey: "vmpShopInfo") as? [String: String] {
                        self.wireFrame?.showTabBar()
                    } else {
                        self.isSelectingShop = true
                        self.wireFrame?.showSelectAddress()
                    }
                }
            }
        } else if event == .willShowTabBar {
            isSelectingShop = false
            main_thread {
                self.wireFrame?.showTabBar()
            }
        }
    }
}

extension LaunchScreenPresenter: LaunchScreenPresenterInterface {
    
}

extension LaunchScreenPresenter: LaunchScreenInteractorOutput {
    
}
