//
//  HomeDetailViewController.swift
//  VinMartPlus
//
//  Created by thanh nguyen on 1/18/18.
//  Copyright © 2018 thanh nguyen. All rights reserved.
//

import UIKit

let giftItems = ["sungtuc", "binhan", "hanhphuc"]

class HomeDetailViewController: BaseViewController, UIGestureRecognizerDelegate {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        return collectionV
    }()
    
    fileprivate lazy var bottomView: BottomView = {
        let aView = BottomView.instanceFromNib()
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    fileprivate lazy var backButton: UIBarButtonItem = {
        let aButton = UIBarButtonItem(image: UIImage(named: "back"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onBackButtonClicked(_:)))
        aButton.tintColor = UIColor(0xFE5721)
        return aButton
    }()
    
    fileprivate lazy var cardButton: UIBarButtonItem = {
        let aButton = UIBarButtonItem(image: UIImage(named: "cardbnt"),
                                      style: .plain,
                                      target: self,
                                      action: #selector(onCardButtonClicked(_:)))
        return aButton
    }()
    
    fileprivate var currentProduct: product!
    fileprivate var allProduct = [product]()
    fileprivate var allGift = [product]()
    
    convenience init(product: product, list: [product], gifts: [product]? = nil) {
        self.init()
        
        self.currentProduct = product
        self.allProduct.append(contentsOf: list)
        self.allGift.removeAll()
        if let giftList = gifts {
            self.allGift.append(contentsOf: giftList)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = self.currentProduct?.name
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        self.setupCollectionView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        bottomView.layoutSubviews()
    }
    
    @objc fileprivate func onBackButtonClicked(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func onCardButtonClicked(_ sender: AnyObject) {
        
    }
    
    func setupCollectionView() {
        self.view.addSubview(collectionView)
        self.view.addSubview(bottomView)
        
        collectionView.top(to: self.topLayoutGuide, withAttribute: .bottom).isActive = true
        collectionView.fillHorizontal(to: self.view)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        bottomView.delegate = self
        bottomView.top(to: collectionView, withAttribute: .bottom).isActive = true
        bottomView.fillHorizontal(to: self.view)
        bottomView.bottom(to: self.view).isActive = true
        bottomView.height(equal: 52).isActive = true
        
        let layout = UICollectionViewFlowLayout()
        layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 40)
        
        collectionView.backgroundColor = UIColor(0xeff0f0)
        collectionView.collectionViewLayout = layout
        collectionView.register(UserColCell.self,
                                forCellWithReuseIdentifier: UserColCell.cellID)
        collectionView.register(GiftCell.self,
                                forCellWithReuseIdentifier: GiftCell.cellID)
        collectionView.register(ProductCollectionCell.self,
                                forCellWithReuseIdentifier: ProductCollectionCell.cellID)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "UICollectionViewCell")
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: UICollectionElementKindSectionHeader)
        collectionView.register(HomeHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: "HomeHeaderCell")
        collectionView.register(HomeDetailHeaderCell.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: "HomeDetailHeaderCell")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension HomeDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 290)
        } else if indexPath.section == 1 && !self.allGift.isEmpty {
            return CGSize(width: collectionView.frame.width, height: 300)
        }
        
        return CGSize(width: (collectionView.frame.width - 5)/2, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 1 {
            return CGSize(width: collectionView.frame.width, height: 54)
        }
        if section == 2 {
            return CGSize(width: collectionView.frame.width, height: 30)
        }
        
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5.0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        var section = 1
        if !self.allGift.isEmpty {
            section += 1
        }
        
        if !self.allProduct.isEmpty {
            section += 1
        }
        
        return section
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.allGift.isEmpty ? self.allProduct.count : self.allGift.count
        case 2:
            return self.allProduct.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard indexPath.section != 0 else { return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                                   withReuseIdentifier: UICollectionElementKindSectionHeader,
                                                                                                   for: indexPath) }
        
        if indexPath.section == 1 {
            if let header =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                             withReuseIdentifier: HomeHeaderCell.cellID,
                                                                             for: indexPath) as? HomeHeaderCell {
                return header
            }
        }
        
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: HomeDetailHeaderCell.cellID,
                                                                         for: indexPath) as? HomeDetailHeaderCell {
            return headerView
        }
        
        
        return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                                withReuseIdentifier: UICollectionElementKindSectionHeader,
                                                                                for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        if section == 0 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserColCell.cellID, for: indexPath) as? UserColCell {
                cell.delegate = self
                cell.nameLabel.text = self.currentProduct?.name
                cell.priceLabel.text = "\(currentProduct.price)"
                let imageName = "VMP_" + "\(self.currentProduct.id)"
                cell.profileImageView.image = UIImage(named: imageName)
                
                return cell
            }
        } else if section == 1 && !self.allGift.isEmpty {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GiftCell.cellID, for: indexPath) as? GiftCell {
                let imageName = "VMP_" + "\(self.allGift[indexPath.row].id)"
                cell.image.image = UIImage(named: imageName)
                
                return cell
            }
        } else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionCell.cellID, for: indexPath) as? ProductCollectionCell {
                cell.name = self.allProduct[indexPath.row].name
                cell.price = "\(self.allProduct[indexPath.row].price)"
                let imageName = "VMP_" + "\(self.allProduct[indexPath.row].id)"
                cell.productImage = UIImage(named: imageName)
                
                return cell
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.section != 0 else { return }
        
        var products = self.allProduct
        var gifts = self.allGift
        if indexPath.section == 1 {
            let gift = self.allGift[indexPath.row]
            
            gifts.remove(at: indexPath.row)
            let vc = HomeDetailViewController(product: gift, list: products, gifts: gifts)
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.section == 2 {
            let product = self.allProduct[indexPath.row]
            
            products.remove(at: indexPath.row)
            let vc = HomeDetailViewController(product: product, list: products, gifts: gifts)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 6, right: 0)
    }
}

extension HomeDetailViewController: CustomBottomViewDelegate, UserColCellInterface {
    func didTapMessage() {
        print("nessage")
    }
    
    func didTapCard() {
        var dic = [String: String]()
        if var userInfo = UserDefaults.standard.array(forKey: "vmpUserInfo") as? [[String: String]] {
            if let index = userInfo.index(where: { $0["productName"] == currentProduct?.name }) {
                
                dic["productName"] = currentProduct?.name
                dic["productPrice"] = "\(currentProduct.price)"
                dic["productImage"] = "VMP_" + "\(currentProduct.id)"
                if let count = userInfo[index]["productCount"] {
                    let valueStirng = "\((Int(count) ?? 0) + 1)"
                    dic["productCount"] = valueStirng
                } else {
                    dic["productCount"] = "1"
                }
                
                userInfo.remove(at: index)
                userInfo.insert(dic, at: index)
            } else {
                dic["productName"] = currentProduct?.name
                dic["productPrice"] = "\(currentProduct.price)"
                dic["productImage"] = "VMP_" + "\(currentProduct.id)"
                dic["productCount"] = "1"
                userInfo.append(dic)
            }
            
            UserDefaults.standard.set(userInfo, forKey: "vmpUserInfo")
        } else {
                dic["productName"] = currentProduct?.name
                dic["productPrice"] = "\(currentProduct.price)"
                dic["productImage"] = "VMP_" + "\(currentProduct.id)"
                dic["productCount"] = "1"
                
                UserDefaults.standard.set([dic], forKey: "vmpUserInfo")
        }
        showToast(withMessage: "Sản phẩm đã được cập nhật vào giỏ hàng của bạn")
//        UserDefaults.standard.removeObject(forKey: "vmpUserInfo")
    }
    
    func didTapBuyNow() {
        var dic = [String: String]()
        
        dic["item"] = currentProduct.name + " X1"
        dic["price"] = "\(currentProduct.price)"
        if let vc = SubmitProductViewController.newFromStoryboard(with: [dic], totalPrice: currentProduct.price) {
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showToast(withMessage: "Có lỗi xảy ra! Không thể mua sản phẩm này ngay bây giờ")
        }
    }
    
    func gotoCardTab() {
        self.tabBarController?.selectedIndex = 2
    }
}
