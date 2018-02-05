//
//  PopupProfileView.swift
//  LEORI
//
//  Created by thanh nguyen on 11/24/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

class PopupProfileView: BaseView {
    
    weak var delegate: PopOverCellActionsDelegate?
    
    fileprivate lazy var container: UIView = {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.white
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let nameLabel: UILabel = {
        let aLabel = UILabel(frame: .zero)
        aLabel.font = UIFont.boldSystemFont(ofSize: 21)
        aLabel.textColor = UIColor(0x000527)
        aLabel.text = "STEVE JOBS"
        aLabel.textAlignment = .left
        aLabel.translatesAutoresizingMaskIntoConstraints = false
        return aLabel
    }()
    
    let avatar: UIImageView = {
        let aImage = UIImageView()
        aImage.contentMode = .scaleToFill
        aImage.translatesAutoresizingMaskIntoConstraints = false
        return aImage
    }()
    
    let infoView: PopupProfileInfoView = {
        let aView = PopupProfileInfoView(frame: .zero)
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    let textView: UITextView = {
        let aView = UITextView(frame: .zero)
        aView.textAlignment = .left
        aView.textColor = UIColor(0x95989a)
        aView.font = UIFont.systemFont(ofSize: 12)
        aView.translatesAutoresizingMaskIntoConstraints = false
        return aView
    }()
    
    let followButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.cornerRadius = 7
        return button
    }()
    
    let blockButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.titleLabel?.textColor = UIColor(0x636363)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.cornerRadius = 7
        return button
    }()
    
    var followers: Int = 0 {
        didSet {
            for view in self.infoView.followersView.subviews {
                if let subView = view as? UILabel {
                    if subView.tag == 101 {
                        subView.text = "\(followers)"
                    } else if subView.tag == 102 {
                        subView.text = "Followers"
                    }
                }
            }
        }
    }
    
    var posts: Int = 0 {
        didSet {
            for view in self.infoView.postView.subviews {
                if let subView = view as? UILabel {
                    if subView.tag == 101 {
                        subView.text = "\(posts)"
                    } else if subView.tag == 102 {
                        subView.text = "Posts"
                    }
                }
            }
        }
    }
    
    var followings: Int = 0 {
        didSet {
            for view in self.infoView.followingView.subviews {
                if let subView = view as? UILabel {
                    if subView.tag == 101 {
                        subView.text = "\(followings)"
                    } else if subView.tag == 102 {
                        subView.text = "Following"
                    }
                }
            }
        }
    }
    
    var datas: [String] = {
       let aContent = "The match will start at 8 p.m BST (3 a.m ET) and will be played at the Ullevaal Stadium in Osto, home of Norwegian national team."
        
        return [aContent, aContent, aContent]
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override internal func setupViews() {
        backgroundColor = UIColor.clear
        
        let topView = UIView(frame: .zero)
        topView.backgroundColor = UIColor.white
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topView)
        topView.top(to: self).isActive = true
        topView.height(equal: 3).isActive = true
        topView.width(equal: 50).isActive = true
        topView.centerX(to: self).isActive = true
        topView.cornerRadius = 1.5
        
        addSubview(container)
        container.top(to: topView, withAttribute: .bottom, equal: 10).isActive = true
        container.fillHorizontal(to: self)
        container.cornerRadius = 10
        
        let bottomView = UIView(frame: .zero)
        bottomView.backgroundColor = UIColor.white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(bottomView)
        bottomView.height(equal: 3).isActive = true
        bottomView.width(equal: 50).isActive = true
        bottomView.centerX(to: self).isActive = true
        bottomView.top(to: container, withAttribute: .bottom, equal: 10).isActive = true
        bottomView.bottom(to: self).isActive = true
        bottomView.cornerRadius = 1.5
        
        // Setup Container
        container.addSubview(nameLabel)
        container.addSubview(avatar)
        
        nameLabel.fillHorizontal(to: container, equal: 47)
        nameLabel.top(to: container, equal: 15).isActive = true
        
        avatar.leading(to: container, equal: 30).isActive = true
        avatar.top(to: nameLabel, withAttribute: .bottom, equal: 15).isActive = true
        avatar.height(equal: 100).isActive = true
        avatar.squareWidthHeight().isActive = true
        avatar.image = UIImage(named: "steve_jobs")
        
        container.addSubview(followButton)
        container.addSubview(blockButton)
        followButton.addTarget(self, action: #selector(onFollowAction(_ :)), for: .touchUpInside)
        blockButton.addTarget(self, action: #selector(onBlockAction(_ :)), for: .touchUpInside)
        
        followButton.top(to: avatar, withAttribute: .bottom, equal: 10).isActive = true
        followButton.leading(to: container, equal: 15).isActive = true
        followButton.trailing(to: blockButton, withAttribute: .leading, equal: -5).isActive = true
        followButton.height(equal: 25).isActive = true
        followButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        followButton.setTitleColor(UIColor(0x636363), for: .normal)
        
        blockButton.top(to: followButton).isActive = true
        blockButton.trailing(to: container, equal: -15).isActive = true
        blockButton.height(equal: 25).isActive = true
        blockButton.width(equalTo: followButton).isActive = true
        blockButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        blockButton.setTitleColor(UIColor(0x636363), for: .normal)
        
        container.addSubview(infoView)
        infoView.top(to: followButton, withAttribute: .bottom, equal: 10).isActive = true
        infoView.fillHorizontal(to: container, equal: 15)
        infoView.height(equal: 50).isActive = true
        
        container.addSubview(tableView)
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44
        self.tableView.fillHorizontal(to: container, equal: 15)
        self.tableView.top(to: infoView, withAttribute: .bottom, equal: 10).isActive = true
        self.tableView.bottom(to: container, equal: 0).isActive = true
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCellIdentifier")
        self.tableView.register(PopUpTableViewCell.self, forCellReuseIdentifier: PopUpTableViewCell.cellID)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func onFollowAction(_ sender: UIButton) {
        delegate?.didClickFollow()
    }
    
    @objc func onBlockAction(_ sender: UIButton) {
        delegate?.didClickBlock()
    }
}

/// MARK: DataSource and delegate for Table View
extension PopupProfileView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: PopUpTableViewCell.cellID, for: indexPath) as? PopUpTableViewCell {
        
            cell.contentLabel.text = datas[indexPath.row]
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "defaultCellIdentifier", for: indexPath)
    }
}

extension PopupProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //To hide section header
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //To hide section header
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
    }
}

class PopupProfileInfoView: BaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    fileprivate lazy var followersView: UIView = {
        let aView = self.createInfoViews()
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    fileprivate lazy var postView: UIView = {
        let aView = self.createInfoViews()
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    fileprivate lazy var followingView: UIView = {
        let aView = self.createInfoViews()
        aView.translatesAutoresizingMaskIntoConstraints = false
        
        return aView
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.white
        cornerRadius = 7
        borderWidth = 1
        borderColor = UIColor.black
        
        let devider1 = UIView(frame: .zero)
        devider1.backgroundColor = UIColor(0x3f4143)
        devider1.translatesAutoresizingMaskIntoConstraints = false
        addSubview(devider1)
        
        let devider2 = UIView(frame: .zero)
        devider2.backgroundColor = UIColor(0x3f4143)
        devider2.translatesAutoresizingMaskIntoConstraints = false
        addSubview(devider2)
        
        addSubview(followersView)
        addSubview(postView)
        addSubview(followingView)
        
        // Setup layout subviews
        followersView.fillVertical(to: self)
        followersView.leading(to: self, equal: 7).isActive = true
        followersView.trailing(to: devider1, withAttribute: .leading).isActive = true
        
        devider1.height(equal: 15).isActive = true
        devider1.width(equal: 2).isActive = true
        devider1.centerY(to: self).isActive = true
        
        postView.fillVertical(to: self)
        postView.centerX(to: self).isActive = true
        postView.width(equalTo: self, equal: -CGFloat(18/3), multiplier: CGFloat(1)/3).isActive = true
        postView.leading(to: devider1, withAttribute: .trailing).isActive = true
        postView.trailing(to: devider2, withAttribute: .leading).isActive = true
        
        devider2.height(equalTo: devider1).isActive = true
        devider2.width(equalTo: devider1).isActive = true
        devider2.centerY(to: self).isActive = true
        
        followingView.fillVertical(to: self)
        followingView.leading(to: devider2, withAttribute: .trailing).isActive = true
        followingView.trailing(to: self, equal: -7).isActive = true
    }
    
    func createInfoViews() -> UIView {
        let aView = UIView(frame: .zero)
        aView.backgroundColor = UIColor.white
        
        let countLabel = UILabel(frame: .zero)
        aView.addSubview(countLabel)
        countLabel.tag = 101
        countLabel.textAlignment = .center
        countLabel.font = UIFont.boldSystemFont(ofSize: 24)
        countLabel.textColor = UIColor(0x636363)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.top(to: aView, equal: 5).isActive = true
        countLabel.fillHorizontal(to: aView, equal: 2)
        countLabel.height(equal: 21).isActive = true
        
        let titleLabel = UILabel(frame: .zero)
        aView.addSubview(titleLabel)
        titleLabel.tag = 102
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.textColor = UIColor(0x757575)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.top(to: countLabel, withAttribute: .bottom, equal: 2).isActive = true
        titleLabel.fillHorizontal(to: countLabel)
        titleLabel.height(equal: 19).isActive = true
        
        return aView
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
