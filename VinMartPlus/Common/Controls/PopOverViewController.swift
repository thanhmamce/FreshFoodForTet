//
//  PopOverViewController.swift
//  LEORI
//
//  Created by thanh nguyen on 11/15/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

enum popOverType {
    case list
    case rate
    case message
    case profile
    
    var keyValue: String {
        switch self {
        case .list: return "key_list"
        case .rate: return "key_rate"
        case .message: return "key_message"
        case .profile: return "key_profile"
        }
    }
}

enum popOverActions {
    case save
    case share
    case hide
    case report
    case topStories
    case mostRecent
    case mostRevelant
    case categories
    case topComment
    case mute
    case block
    
    var textValue: String {
        switch self {
        case .save: return "Save"
        case .share: return "Share"
        case .hide: return "Hide"
        case .report: return "Report"
        case .topStories: return "Top Stories"
        case .mostRecent: return "Most Recent"
        case .mostRevelant: return "Most Revelant"
        case .categories: return "Categories"
        case .topComment: return "Top Comment"
        case .mute: return "Mute"
        case .block: return "Block"
        }
    }
}

class PopOverViewController: UIViewController {
    fileprivate lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionV = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionV.translatesAutoresizingMaskIntoConstraints = false
        return collectionV
    }()
    
    fileprivate lazy var ratingView: PopupRateView = {
        let aView = PopupRateView(frame: .zero)
        aView.backgroundColor = UIColor.clear
        aView.translatesAutoresizingMaskIntoConstraints = false
        
       return aView
    }()
    
    fileprivate lazy var profileView: PopupProfileView = {
        let aView = PopupProfileView(frame: .zero)
        aView.backgroundColor = UIColor.clear
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    fileprivate lazy var topIndicator: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.red// UIColor(0xE81623)
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    fileprivate lazy var botIndicator: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.red// UIColor(0xE81623)
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    weak var delegate: PopOverViewDelegate?
    
    fileprivate var rateEditing: Bool = false
    fileprivate var heightConst: NSLayoutConstraint!
    fileprivate var centerYConst: NSLayoutConstraint!
    fileprivate var headerTitle: String?
    fileprivate var popOverData: [String:Any]?
    fileprivate var type: popOverType = .list
    fileprivate var request: String = ""
    
    convenience init(header: String? = nil, type: popOverType, params: [String:Any]? = nil, requestType: String = "") {
        self.init()
        
        self.headerTitle = header
        self.type = type
        self.popOverData = params
        self.request = requestType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.view.blurEffect()
        if self.type == .list || self.type == .message {
            self.view.bringSubview(toFront: self.collectionView)
        } else if self.type == .rate {
            self.view.bringSubview(toFront: self.ratingView)
        } else if self.type == .profile {
            self.view.bringSubview(toFront: self.profileView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let firstTouch = touches.first else { return }
        if self.type == .rate && !self.ratingView.frame.contains(firstTouch.location(in: self.view)) {
            if rateEditing == true {
                self.view.endEditing(true)
            } else {
                dismiss(animated: false)
            }
        }
        
        if self.type == .profile && !self.profileView.frame.contains(firstTouch.location(in: self.view)) {
            dismiss(animated: false)
        }
        
        if (self.type == .message || self.type == .list) && !self.collectionView.frame.contains(firstTouch.location(in: self.view)) {
            dismiss(animated: false)
        }
    }
    
    func setupLayout() {
        switch self.type {
        case .list, .message:
            setupCollectionView()
            break
        case .rate:
            setupRatingView()
            break
        case .profile:
            setupProfileView()
            break
        }
    }

    func setupRatingView() {
        self.view.addSubview(ratingView)
        
        ratingView.fillHorizontal(to: self.view, equal: 25)
        centerYConst = ratingView.centerY(to: self.view)
        centerYConst.isActive = true
        heightConst = ratingView.height(equal: 0)
        heightConst.isActive = true
        heightConst.constant = 330
        ratingView.leftButton.setTitle("Man Unt", for: .normal)
        ratingView.leftButton.setTitleColor(UIColor(0x353738), for: .normal)
        ratingView.rightButton.setTitle("Real Madrid", for: .normal)
        ratingView.rightButton.setTitleColor(UIColor(0x353738), for: .normal)
    }
    
    func setupProfileView() {
        self.view.addSubview(profileView)
        
        profileView.fillHorizontal(to: self.view, equal: 10)
        centerYConst = profileView.centerY(to: self.view)
        centerYConst.isActive = true
        heightConst = profileView.height(equal: 476)
        heightConst.isActive = true
        
        profileView.followButton.setTitle("Follow", for: .normal)
        profileView.blockButton.setTitle("Block", for: .normal)
        profileView.followers = 124
        profileView.posts = 457
        profileView.followings = 1500
    }
    
    func setupCollectionView() {
        guard let optionList = self.popOverData?[self.type.keyValue] as? [String] else { return }
        
        self.view.addSubview(collectionView)
        self.view.addSubview(botIndicator)
        self.view.addSubview(topIndicator)
        
        self.topIndicator.height(equal: 3).isActive = true
        self.topIndicator.width(equal: 50).isActive = true
        self.topIndicator.centerX(to: self.view).isActive = true
        self.topIndicator.cornerRadius = 1.5
        
        self.collectionView.topToBottom(of: self.topIndicator, equal: 6).isActive = true
        self.collectionView.leading(to: self.view, equal: 10).isActive = true
        self.collectionView.trailing(to: self.view, equal: -10).isActive = true
        self.collectionView.centerY(to: self.view).isActive = true
        self.heightConst = self.collectionView.height(equal: 0)
        self.heightConst.isActive = true
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.cornerRadius = 10
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.botIndicator.topToBottom(of: self.collectionView, equal: 6).isActive = true
        self.botIndicator.height(equal: 3).isActive = true
        self.botIndicator.width(equal: 50).isActive = true
        self.botIndicator.centerX(to: self.view).isActive = true
        self.botIndicator.cornerRadius = 1.5
        
        if let _ = self.headerTitle {
            let layout = UICollectionViewFlowLayout()
            layout.headerReferenceSize = CGSize(width: self.view.bounds.size.width, height: 40)
            self.collectionView.collectionViewLayout = layout
            self.heightConst.constant = min(480, CGFloat(50*optionList.count + 40 + 30))
        } else {
            self.heightConst.constant = min(480, CGFloat(50*optionList.count + 30))
        }
        
        self.collectionView.register(PopupCollectionViewCell.self, forCellWithReuseIdentifier: PopupCollectionViewCell.cellID)
//        self.collectionView.register(PopupIndicatorViewCell.self, forCellWithReuseIdentifier: PopupIndicatorViewCell.cellID)
        self.collectionView.register(PopupMessageViewCell.self, forCellWithReuseIdentifier: PopupMessageViewCell.cellID)
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                withReuseIdentifier: UICollectionElementKindSectionHeader)
    }

    @objc func keyboardWillShow(_ noti: Notification) {
        rateEditing = true
        main_thread {
            guard let userInfo = noti.userInfo as NSDictionary? else { return }
            
            if let keypadSize = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as? CGRect {
                let keypadHeight = keypadSize.height
                let space = self.view.frame.height - (self.ratingView.center.y + self.ratingView.frame.height/2)
                
                if space < keypadHeight {
                    UIView.animate(withDuration: ((userInfo.object(forKey: UIKeyboardAnimationCurveUserInfoKey) as AnyObject).doubleValue)!, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                        self.centerYConst.constant = (space - keypadHeight) - 20
                    }, completion: nil)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        rateEditing = false
        UIView.animate(withDuration: 0.3) {
            self.centerYConst.constant = 0
        }
    }
}

extension PopOverViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        guard indexPath.section == 1 else {
//            return CGSize(width: self.collectionView.frame.width, height: 15)
//        }
//
        return CGSize(width: self.collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if let _ = self.headerTitle, section == 1 {
            return CGSize(width: self.collectionView.frame.width, height: 40)
        } else {
            return CGSize(width: self.collectionView.frame.width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
}

extension PopOverViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let optionList = self.popOverData?[self.type.keyValue] as? [String] else { return 0 }
        
        return optionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let optionList = self.popOverData?[self.type.keyValue] as? [String] else { return UICollectionViewCell() }
        
        if self.type == .list {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopupCollectionViewCell.cellID, for: indexPath) as? PopupCollectionViewCell {
                cell.title.text = optionList[indexPath.row]
                cell.title.textColor = UIColor.white
                if indexPath.row == 0 && self.headerTitle == nil {
                    cell.roundCorners(corners: [.topLeft, .topRight], radius: 10)
                }
                
                if indexPath.row == (optionList.count - 1) {
                    cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
                }
                
                return cell
            }
        } else if self.type == .message {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopupMessageViewCell.cellID, for: indexPath) as? PopupMessageViewCell {
                cell.title.text = optionList[indexPath.row]
                cell.title.textColor = UIColor(0x515151)
                cell.delegate = self
                if indexPath.row == 0 && self.headerTitle == nil {
                    cell.roundCorners(corners: [.topLeft, .topRight], radius: 10)
                } else if indexPath.row == (optionList.count - 1) {
                    cell.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 10)
                }
                
                return cell
            }
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                         withReuseIdentifier: UICollectionElementKindSectionHeader,
                                                                         for: indexPath)
        
        headerView.backgroundColor = UIColor.white
        headerView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
        if let header = self.headerTitle {
            let title = UILabel(frame: CGRect(x: 16, y: 0, width: self.view.bounds.width, height: 40))
            title.text = header
            title.textColor = UIColor.black
            title.font = UIFont.boldSystemFont(ofSize: 16)
            title.numberOfLines = 0
            title.lineBreakMode = .byWordWrapping
            headerView.addSubview(title)
        }
        
        return headerView
    }
}

extension PopOverViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let optionList = self.popOverData?[self.type.keyValue] as? [String], optionList.count > indexPath.row else { return }
        if self.type == .list {
            if request == "ward" || request == "dicstrict" {
                delegate?.didSelectedOption(at: indexPath.row, value: request)
            } else {
                delegate?.didSelectedOption(at: indexPath.row, value: optionList[indexPath.row])
            }
            
            dismiss(animated: false)
        }
    }
}

extension PopOverViewController: PopOverCellActionsDelegate {
    func didClickSendMessage() {
        print("Sending message")
        // Need Implement
    }
    
    func didClickFollow() {
        // Need Implement
        print("on Follow action")
    }
    
    func didClickBlock() {
        // Need Implement
        print("on Block action")
    }
}
