//
//  PreviewViewController.swift
//  Print2PDF
//
//  Created by Gabriel Theodoropoulos on 14/06/16.
//  Copyright © 2016 Appcoda. All rights reserved.
//

import UIKit
import MessageUI

let titles = ["Đến của hàng Vinmart+ gần nhất", "Chuyển khoản trước 1 nửa và thanh toán phần còn lại khi nhận hàng"]
let subTitles = ["", "Bạn chỉ cần chuyển khoản 1 nửa số tiền đến tài khoản của Vinmart+ (thông tin như bên dưới với nội dung: \"ABC\" và thanh toán nốt phần còn lại khi chúng tồi giao hàng đến địa chỉ chị bạn đã cung cấp"]

class PayInfoViewController: UIViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    weak var delegate: ProductPagerDelegate?
    
    fileprivate let defaultCellIdentifier = "DefaultCellIdentifier"
    fileprivate var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.prepareTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let _ = selectedIndex {
            delegate?.enableBottomBnt()
        }
    }
    
    fileprivate func prepareTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView.backgroundColor = UIColor(0xeff0f0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.sectionHeaderHeight = 44
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    func getTransferMethod() -> String {
        if let index = self.selectedIndex {
            return index == 0 ? "Đến cửa hàng thanh toán" : "Chuyển khoản 1 nửa và thanh toán phần còn lại khi nhận hàng"
        }
        
        return "Đến cửa hàng thanh toán"
    }
}

extension PayInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: defaultCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        if indexPath.row == selectedIndex {
            cell.detailTextLabel?.text = subTitles[indexPath.row]
            cell.detailTextLabel?.numberOfLines = 0
            cell.detailTextLabel?.lineBreakMode = .byWordWrapping
            cell.detailTextLabel?.textColor = UIColor.orange
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
            cell.detailTextLabel?.text = nil
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.row == self.selectedIndex {
            return 125.0
        }
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        delegate?.enableBottomBnt()
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Hãy lựa chọn phương thức thanh toán ban muốn"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as? UITableViewHeaderFooterView
        header?.textLabel?.textColor = UIColor.orange
    }
    
}
