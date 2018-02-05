//
//  HomeViewController.swift
//  LEORI
//
//  Created by Gadapxichlo on 7/26/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol HomeViewInterface: BaseViewInterface {
    
}

class HomeViewController: BaseViewController {
    fileprivate var presenter: HomePresenterInterface?
    @IBOutlet fileprivate weak var contentContainerView: UIView!
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet weak var containerTopConst: NSLayoutConstraint!
    
    fileprivate weak var pager: HomePager?
    fileprivate var timer : Timer?
    fileprivate let defaultCellIdentifier = "DefaultCellIdentifier"
    fileprivate var products = [product]()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "home_pager" {
            if let destination = segue.destination as? HomePager {
                pager = destination
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = basePresenter as? HomePresenterInterface
        presenter?.viewDidLoad()
        
        self.prepareNavigationBar()
        self.preparePager()
        self.prepareTableView()
        
        if let productList = presenter?.getProducts(), !productList.isEmpty {
            self.products.removeAll()
            self.products.append(contentsOf: productList)
        } else {
            self.products.append(product())
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.viewWillAppear()
        startTimer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        presenter?.viewDidDisappear()
        stopTimer()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func prepareNavigationBar() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    fileprivate func preparePager() {
        guard let pager = pager else { return }
        
        pager.pageDelegate = self
        pager.customPageDelegate = self
    }
    
    fileprivate func prepareTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        // TableView
        tableView.backgroundColor = UIColor(0xeff0f0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: defaultCellIdentifier)
        tableView.register(ProductTableCell.self, forCellReuseIdentifier: ProductTableCell.cellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 44
        tableView.estimatedRowHeight = 250
        tableView.separatorStyle = .none
    }
    
    fileprivate func startTimer() {
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(doChangePage(_ :)), userInfo: nil, repeats: true)
    }
    
    fileprivate func stopTimer() {
        guard timer != nil else { return }
        timer?.invalidate()
        timer = nil
    }
    
    @objc fileprivate func doChangePage(_ sender: AnyObject) {
        pager?.move(to: ((pager?.currentPageIndex ?? 0) + 1)%3)
    }
    
    fileprivate func gotoDetailView(of item: product, and list: [product]) {
        let gifts = self.createGifts()
        let vc = HomeDetailViewController(product: item, list: list, gifts: gifts)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func createGifts() -> [product] {
        let sungtucDic = ["A": "sungtuc", "B": "101", "C": "Giỏ quà Sung Túc", "E": "499000"]
        let hanhphucDic = ["A": "hanhphuc", "B": "102", "C": "Giỏ quà Hạnh Phúc", "E": "299000"]
        let binhanDic = ["A": "binhan", "B": "103", "C": "Giỏ quà Bình An", "E": "699000"]
        var gifts = [product]()
        
        gifts.append(product(with: sungtucDic))
        gifts.append(product(with: hanhphucDic))
        gifts.append(product(with: binhanDic))
        
        return gifts
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableCell.cellID,
                                                    for: indexPath) as? ProductTableCell {
            let imageName = "VMP_" + "\(self.products[indexPath.row].id)"
            cell.name = self.products[indexPath.row].name
            cell.price = "\(self.products[indexPath.row].price)"
            cell.productImage = UIImage(named: imageName)
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.products[indexPath.row]
        let list = self.products.filter({ $0.id != item.id })
        
        self.gotoDetailView(of: item, and: list)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Danh sách sản phẩm"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.orange
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard abs(containerTopConst.constant) < contentContainerView.frame.height ||
            scrollView.contentOffset.y < contentContainerView.frame.height else { return }
        
        if scrollView.contentOffset.y > contentContainerView.frame.height {
            containerTopConst.constant = -contentContainerView.frame.height
        }
        
        containerTopConst.constant = -scrollView.contentOffset.y
        if containerTopConst.constant > 0 {
            containerTopConst.constant = 0
        }
    }
}

extension HomeViewController: HomeViewInterface {
    
}

extension HomeViewController: BasePagesViewControllerDelegate {
    func pageViewControllerWillChangePage() {
        
    }
    
    func pageViewControllerDidChange(to page: Int) {
        
    }
}

extension HomeViewController: HomePagerDelegate {
    func didClickOnPoll(_ id: String) {
        
    }
}
