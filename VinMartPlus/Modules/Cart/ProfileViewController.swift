//
//  ProfileViewController.swift
//  LEORI
//
//  Created by KODAK on 8/22/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol ProfileViewInterface: BaseViewInterface {
    
}

class ProfileViewController: BaseViewController {
    fileprivate var presenter: ProfilePresenterInterface?
    
    fileprivate lazy var noDataView: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.white
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var priceSum: UILabel!
    
    fileprivate var inEditing: Bool = false
    fileprivate var priceAll: Int = 0
    fileprivate var savedItems = [userInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewDidLoad()
        
        self.prepareNavigationBar()
        self.prepareTableView()
        
        editBtn.setImage(UIImage(named: "edit")?.changeImageColor(tintColor: UIColor(0x2BB673)), for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        
        savedItems.removeAll()
        priceAll = 0
        if let items = UserDefaults.standard.array(forKey: "vmpUserInfo") as? [[String: String]] {
            for item in items {
                let savedItem = userInfo(with: item)
                let price = savedItem.price * savedItem.count
                priceAll += price
                priceSum.text = "\(priceAll)"

                savedItems.append(savedItem)
            }
        }
        
        if savedItems.isEmpty {
            self.setupNodataView()
        } else {
            noDataView.removeFromSuperview()
            noDataView.isHidden = true
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if savedItems.isEmpty {
            showToast(withMessage: "Hãy quay lại trang chủ để chọn sản phẩm bạn muốn mua")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
    }
    
    fileprivate func prepareTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        // TableView
        tableView.backgroundColor = UIColor(0xeff0f0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.register(CartViewCell.self, forCellReuseIdentifier: CartViewCell.cellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 44
        tableView.estimatedRowHeight = 250
        tableView.separatorStyle = .none
    }
    
    fileprivate func prepareNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func setupNodataView() {
        self.view.addSubview(noDataView)
        noDataView.isHidden = false
        
        noDataView.fill(to: self.view)
        
        let aLabel = UILabel(frame: .zero)
        aLabel.text = "Giỏ hàng của bạn chưa có sản phẩm nào"
        aLabel.textColor = UIColor(0x252525)
        aLabel.font = UIFont.systemFont(ofSize: 16)
        aLabel.textAlignment = .center
        aLabel.sizeToFit()
        noDataView.addSubview(aLabel)
        
        // setup constraints
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        aLabel.fillHorizontal(to: noDataView)
        aLabel.centerY(to: noDataView).isActive = true
    }
    
    @IBAction func onBuyAction(_ sender: Any) {
        var itemDic = [[String: String]]()
        for item in savedItems {
            var dic = [String: String]()
            let price = item.price * item.count
            
            dic["item"] = item.name + "<br>X\(item.count)"
            dic["price"] = "\(price)"
            itemDic.append(dic)
        }
        if let vc = SubmitProductViewController.newFromStoryboard(with: itemDic, totalPrice: priceAll) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func onEditAction(_ sender: Any) {
        inEditing = !inEditing
        if inEditing {
            editBtn.setImage(UIImage(named: "done"), for: .normal)
        } else {
            editBtn.setImage(UIImage(named: "edit")?.changeImageColor(tintColor: UIColor(0x2BB673)), for: .normal)
        }
        self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CartViewCell.cellID, for: indexPath) as? CartViewCell {
            cell.delegate = self
            cell.iconImage.image = UIImage(named: savedItems[indexPath.row].imageName)
            cell.deleteButton.isHidden = !inEditing
            cell.nameLabel.text = savedItems[indexPath.row].name
            cell.priceLabel.text = "\(savedItems[indexPath.row].price)"
            cell.stepperBnt.value = Double(savedItems[indexPath.row].count)
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    }
}

extension ProfileViewController: CartViewCellDelegate {
    func didClickDeleteButton(_ cell: UITableViewCell) {
        if let indexPath = self.tableView.indexPath(for: cell) {
            let savedItem = savedItems[indexPath.row]
            if var items = UserDefaults.standard.array(forKey: "vmpUserInfo") as? [[String: String]] {
                if let index = items.index(where: { $0["productName"] == savedItem.name && $0["productPrice"] == "\(savedItem.price)" }) {
                    
                    items.remove(at: index)
                    UserDefaults.standard.set(items, forKey: "vmpUserInfo")
                    
                    let price = savedItem.price * savedItem.count
                    priceAll -= price
                    priceSum.text = "\(priceAll)"
                    savedItems.remove(at: indexPath.row)
                    self.tableView.reloadData()
                    
                    return
                }
            }
        }
        
        showToast(withMessage: "Có lỗi xảy ra! Hãy thử lại sau")
    }
    
    func updatePriceSum(with cell: UITableViewCell, delta: Int) {
        guard let indexPath = self.tableView.indexPath(for: cell), indexPath.row < self.savedItems.count else { return }
        
        self.savedItems[indexPath.row].count += delta
        let price = self.savedItems[indexPath.row].price
        let newPrice = priceAll + (delta * price)
        
        priceAll = newPrice
        priceSum.text = "\(newPrice)"
    }
}

