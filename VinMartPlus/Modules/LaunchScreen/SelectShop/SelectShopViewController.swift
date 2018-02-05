//
//  SelectShopViewController.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit
//import SwipeCellKit

protocol SelectShopViewInterface: BaseViewInterface {
    
}

class SelectShopViewController: BaseViewController {
    fileprivate var presenter: SelectShopPresenterInterface?
    
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var citytBnt: UIButton!
    @IBOutlet fileprivate weak var cityImg: UIImageView!
    @IBOutlet fileprivate weak var dicstrictBnt: UIButton!
    @IBOutlet fileprivate weak var dicstrictImg: UIImageView!
    @IBOutlet fileprivate weak var wardBnt: UIButton!
    @IBOutlet fileprivate weak var wardImg: UIImageView!
    @IBOutlet fileprivate weak var searchBnt: UIButton!
    
    fileprivate var dicstricts = [String]()
    fileprivate var wards = [String]()
    fileprivate var shops = [shop]()
    fileprivate var selectedDicstrict: String?
    fileprivate var selectedWard: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? SelectShopPresenterInterface
        presenter?.viewDidLoad()
        
        self.prepareNavigationBar()
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        searchBnt.isEnabled = false
        
        let dicstrictList = CoreHandler.shared.dataManager.getDicstricts()
        if dicstrictList.count > 0 {
            dicstricts.removeAll()
            dicstricts.append(contentsOf: dicstrictList)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        citytBnt.isEnabled = false
        citytBnt.setTitle("Hà Nội", for: .normal)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
    
    fileprivate func prepareNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }

    func onMoreAction(actions: [String], request: String) {
        var params = [String: Any]()
        params[popOverType.list.keyValue] = actions
        let vc = PopOverViewController(header: nil, type: .list, params: params, requestType: request)
        vc.delegate = self
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func onChooseDicstrict(_ sender: AnyObject) {
        self.onMoreAction(actions: dicstricts, request: "dicstrict")
    }
    
    @IBAction func onChooseWard(_ sender: AnyObject) {
        if let dicstrict = selectedDicstrict {
            let wards = CoreHandler.shared.dataManager.getWards(at: dicstrict)
            self.wards = wards
            self.onMoreAction(actions: wards, request: "ward")
        } else {
            showAlert(withTitle: "", message: "Bạn chưa chọn Quận/Huyện")
        }
    }
    
    @IBAction func onSearchAction(_ sender: Any) {
        if let dicstrict = self.selectedDicstrict, let ward = self.selectedWard {
            self.shops = CoreHandler.shared.dataManager.getShopList(at: dicstrict, ward: ward)
            let shopAdds = self.shops.map({ $0.address })
            self.onMoreAction(actions: shopAdds, request: "address")
        } else {
            showAlert(withTitle: "", message: "Bạn cần chọn Quân/Huyện và Phường/Xã trước khi tìm kiếm")
        }
    }
    
}

extension SelectShopViewController: PopOverViewDelegate {
    func didSelectedOption(at row: Int, value: String) {
        
        if value == "dicstrict" {
            selectedDicstrict = self.dicstricts[row]
            dicstrictBnt.setTitle(selectedDicstrict, for: .normal)
        } else if value == "ward" {
            selectedWard = self.wards[row]
            wardBnt.setTitle(selectedWard, for: .normal)
            if let _ = selectedWard, let _ = selectedDicstrict {
                searchBnt.isEnabled = true
            }
        } else {
            showToast(withMessage: "Đã lưu cửa hàng bạn chọn. Chuyển về trang chủ và bắt đầy mua hàng")
            selectedDicstrict = nil
            selectedWard = nil
            var dic = [String: String]()
            let shop = self.shops[row]
            dic["savedShopName"] = shop.name
            dic["savedShopEmail"] = shop.email
            dic["savedShopManagerPhoneNumber"] = shop.managerPhoneNumber
            dic["savedShopPhoneNumber"] = shop.shopPhoneNumber
            dic["savedShopCellphone"] = shop.cellphone
            dic["savedShopAddress"] = shop.address
            
            if var _ = UserDefaults.standard.object(forKey: "vmpShopInfo") as? [String: String] {
                UserDefaults.standard.removeObject(forKey: "vmpShopInfo")
                UserDefaults.standard.set(dic, forKey: "vmpShopInfo")
            } else {
                UserDefaults.standard.set(dic, forKey: "vmpShopInfo")
                self.dismiss(animated: true, completion: {
                    self.presenter?.showTabbar()
                })
            }
        }
    }
}

extension SelectShopViewController: SelectShopViewInterface {
    
}

