//
//  DataManagerDelegate.swift
//  LEORI
//
//  Created by Gadapxichlo on 10/2/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

class WeakSet<ObjectType>: Sequence {
    
    var count: Int {
        return weakStorage.count
    }
    
    fileprivate let weakStorage = NSHashTable<AnyObject>.weakObjects()
    
    func addObject(_ object: ObjectType) {
        weakStorage.add(object as AnyObject?)
    }
    
    func removeObject(_ object: ObjectType) {
        weakStorage.remove(object as AnyObject?)
    }
    
    func removeAllObjects() {
        weakStorage.removeAllObjects()
    }
    
    func containsObject(_ object: ObjectType) -> Bool {
        return weakStorage.contains(object as AnyObject?)
    }
    
    func makeIterator() -> AnyIterator<ObjectType> {
        let enumerator = weakStorage.objectEnumerator()
        return AnyIterator {
            return enumerator.nextObject() as? ObjectType
        }
    }
}

struct userInfo {
    var name: String
    var price: Int
    var count: Int
    var imageName: String
    
    init(with dictionary: [String: String]) {
        self.name = dictionary["productName"] ?? "Tên món ăn"
        self.price = 0
        if let priceString = dictionary["productPrice"]?.trimmingCharacters(in: .whitespaces) {
            self.price = Int(priceString.replacingOccurrences(of: ",", with: "")) ?? 0
        }
        self.count = Int(dictionary["productCount"] ?? "1") ?? 1
        self.imageName = dictionary["productImage"] ?? ""
    }
    
    init() {
        self.name = "Tên món ăn"
        self.price = 0
        self.count = 1
        self.imageName = ""
    }
}

struct product {
    var id: String
    var code: String
    var name: String
    var DVT: String
    var price: Int = 0
    
    init(with dictionary: [String: String]) {
        self.id = dictionary["A"] ?? "STT"
        self.code = dictionary["B"] ?? "Mã hàng"
        self.name = dictionary["C"] ?? "Tên món ăn"
        self.DVT = dictionary["D"] ?? "DVT"
        if let priceString = dictionary["E"]?.trimmingCharacters(in: .whitespaces) {
            self.price = Int(priceString.replacingOccurrences(of: ",", with: "")) ?? 0
        }
    }
    
    init() {
        self.id = "STT"
        self.code = "Mã hàng"
        self.name = "Tên món ăn"
        self.DVT = "DVT"
    }
}

struct shop {
    var name: String
    var dicstrict: String
    var ward: String
    var address: String
    var CHPKiemNhiem: String
    var cellphone: String
    var shopPhoneNumber: String
    var managerPhoneNumber: String
    var email: String
    var CDV: String
    
    init(with dictionary: [String: String]) {
        self.name = dictionary["A"] ?? "Tên cửa hàng"
        self.dicstrict = dictionary["B"] ?? "Quận / Huyện"
        self.ward = dictionary["C"] ?? "Phường/Xã"
        self.address = dictionary["D"] ?? "Địa chỉ cửa hàng"
        self.CHPKiemNhiem = dictionary["E"] ?? "CHT/CHP kiêm nhiệm"
        self.cellphone = dictionary["F"] ?? "SĐT di động"
        self.shopPhoneNumber = dictionary["G"] ?? "SĐT cửa hàng"
        self.managerPhoneNumber = dictionary["H"] ?? "SĐT QLKV"
        self.email = dictionary["I"] ?? "Email"
        self.CDV = dictionary["J"] ?? "GĐV"
    }
    
    
    init(_ fname: String) {
        self.name = ""
        self.dicstrict = ""
        self.ward = ""
        self.address = fname;
        self.CHPKiemNhiem = ""
        self.cellphone = ""
        self.shopPhoneNumber = ""
        self.managerPhoneNumber = ""
        self.email = ""
        self.CDV = ""
    }
}

protocol DataManagerDelegate: class {
    func didSuccessGetPolls(_ items: [shop]?, withError error: Error?)
}

extension DataManagerDelegate {
    func didSuccessGetPolls(_ items: [shop]?, withError error: Error?) {}
}

