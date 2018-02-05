//
//  DataManager.swift
//  Taxi Dispatching
//
//  Created by Gadapxichlo on 2/23/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import Foundation

let rows = 438
let cols = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

protocol DataManagerInterface {
    weak var delegate: DataManagerDelegate? { get set }
    
    func isDataAvaiable() -> Bool
    func getDicstricts() -> [String]
    func getWards(at dicstrict: String) -> [String]
    func getShopList(at dicstrict: String, ward: String) -> [shop]
    func getProducts() -> [product]
}

class DataManager {
    fileprivate let weakDelegators = WeakSet<DataManagerDelegate>()
    fileprivate var products = [product]()
    fileprivate var shops = [shop]()
    fileprivate var dicstricts = [String]()
    fileprivate var wardDic = [String: [String]]()
    fileprivate var isLoadedData = false
    
    init() {
    }
    
    func initialize() {
        background_thread {
//            self.loadData()
            self.loadJsonData()
        }
    }
    
    fileprivate func loadData() {
        var shopDic = [[String: String]]()
        var productDic = [[String: String]]()
        if let path = Bundle.main.path(forResource: "newData", ofType: "xlsx") {
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(path)
            if let worksheet: BRAWorksheet = spreadsheet.workbook.worksheets[0] as? BRAWorksheet {

                // Loading shops list
                for i in 3...rows {
                    var dic = [String: String]()
                    var dicstrict: String = ""
                    for col in cols {
                        let cellStr = col + "\(i)"
                        let cell: BRACell = worksheet.cell(forCellReference: cellStr)
                        dic[col] = cell.stringValue().condensedWhitespace.trimmingCharacters(in: .whitespaces)

                        if col == "B" {
                            dicstrict = dic[col] ?? ""
                            let item = dicstricts.filter({ $0.caseInsensitiveCompare(dicstrict) == ComparisonResult.orderedSame })
                            if item.isEmpty {
                                dicstricts.append(dicstrict)
                            }
                        } else if col == "C" {
                            if var value = wardDic[dicstrict.lowercased()], !value.isEmpty {
                                value.append(dic[col] ?? "")
                                wardDic[dicstrict.lowercased()] = value
                            } else {
                                wardDic[dicstrict.lowercased()] = [dic[col] ?? ""]
                            }
                        }
                    }

                    shopDic.append(dic)
                    shops.append(shop(with: dic))
                }
            }

            if let worksheet: BRAWorksheet = spreadsheet.workbook.worksheets[1] as? BRAWorksheet {
                for i in 3...16 {
                    var dic = [String: String]()
                    for col in ["A", "B", "C", "D", "E"] {
                        let cellStr = col + "\(i)"
                        let cell: BRACell = worksheet.cell(forCellReference: cellStr)
                        dic[col] = cell.stringValue()
                    }
                    productDic.append(dic)
                    products.append(product(with: dic))
                }
            }
        }
        
        isLoadedData = true
        let validDictionary = ["shoplist": 1, "shops": shopDic, "products": productDic] as [String : AnyObject]
        if JSONSerialization.isValidJSONObject(validDictionary) {
            do {
                let rawData = try JSONSerialization.data(withJSONObject: validDictionary, options: .prettyPrinted)
                if let url = Bundle.main.url(forResource: "userData", withExtension: "json") {
                    do {
                        let _ = try rawData.write(to: url, options: .atomic)
                    } catch {
                        print("can not write to json file")
                    }
                } else {
                    print("Url is not correct")
                }
            } catch {
                print("Not valid Json object")
            }
        }
        
        if products.count > 0 && dicstricts.count > 0 && wardDic.count > 0 {
            CoreHandler.shared.eventManager.notifyListener(.didLoadedData, params: nil)
        } else {
            CoreHandler.shared.eventManager.notifyListener(.didLoadedData,
                                                           params: NSError(domain: "Can't load data", code: 0, userInfo: nil))
        }
        
    }
    
    fileprivate func loadJsonData() {
        if let url = Bundle.main.url(forResource: "userData", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                
                do {
                    let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let dictionary = object as? [String: AnyObject] {
                        readJSONObject(object: dictionary)
                    } else {
                        CoreHandler.shared.eventManager.notifyListener(.didLoadedData,
                                                                       params: NSError(domain: "Can't load data", code: 0, userInfo: nil))
                    }
                } catch {
//                    print("Format data is incorrect!")
                    CoreHandler.shared.eventManager.notifyListener(.didLoadedData,
                                                                   params: NSError(domain: "Can't load data", code: 0, userInfo: nil))
                }
            } catch {
//                print("Can not init data from json file")
                CoreHandler.shared.eventManager.notifyListener(.didLoadedData,
                                                               params: NSError(domain: "Can't load data", code: 0, userInfo: nil))
            }
        }
    }
    
    fileprivate func readJSONObject(object: [String: AnyObject]) {
        guard let shopItems = object["shops"] as? [[String: String]],
            let productItems = object["products"] as? [[String: String]] else { return }
        
        self.shops.removeAll()
        for shopItem in shopItems {
            self.shops.append(shop(with: shopItem))
            if let dicstrict = shopItem["B"] {
                let item = dicstricts.filter({ $0.caseInsensitiveCompare(dicstrict) == ComparisonResult.orderedSame })
                if item.isEmpty {
                    dicstricts.append(dicstrict)
                }
                
                if let ward = shopItem["C"] {
                    if var value = wardDic[dicstrict.lowercased()], !value.isEmpty {
                        value.append(ward)
                        wardDic[dicstrict.lowercased()] = value
                    } else {
                        wardDic[dicstrict.lowercased()] = [ward]
                    }
                }
            }
        }
        
        self.products.removeAll()
        for productItem in productItems {
            self.products.append(product(with: productItem))
        }
        
        if products.count > 0 && dicstricts.count > 0 && wardDic.count > 0 {
            CoreHandler.shared.eventManager.notifyListener(.didLoadedData, params: nil)
        } else {
            CoreHandler.shared.eventManager.notifyListener(.didLoadedData,
                                                           params: NSError(domain: "Can't load data", code: 0, userInfo: nil))
        }
        self.isLoadedData = true
    }
}

extension DataManager: DataManagerInterface {
    weak var delegate: DataManagerDelegate? {
        get {
            return nil
        }
        set(newDelegate) {
            guard let newDelegate = newDelegate else {
                return
            }
            
            background_thread {
                synchronized(self.weakDelegators, closure: {
                    if self.weakDelegators.containsObject(newDelegate) {
                        return
                    }
                    
                    self.weakDelegators.addObject(newDelegate)
                })
            }
        }
    }
    
    func isDataAvaiable() -> Bool {
        return isLoadedData
    }
    
    func getDicstricts() -> [String] {
        return self.dicstricts
    }
    
    func getWards(at dicstrict: String) -> [String] {
        guard let wards = self.wardDic[dicstrict.lowercased()] else { return [""] }
        
        return wards
    }
    
    func getShopList(at dicstrict: String, ward: String) -> [shop] {
        return self.shops.filter({ $0.dicstrict == dicstrict && $0.ward == ward })
    }
    
    func getProducts() -> [product] {
        return self.products
    }
}


