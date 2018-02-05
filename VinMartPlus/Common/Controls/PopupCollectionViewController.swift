//
//  PopupTableViewController.swift
//  LEORI
//
//  Created by THANH on 11/08/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

let POPUP_CELL_HEIGHT = CGFloat(33)

class PopupCollectionViewController: BaseCollectionViewController, UICollectionViewDelegateFlowLayout {

    fileprivate var m_optionList = [NSAttributedString]()
    fileprivate var m_completion: ((Int) -> Void)?
    fileprivate var m_anchorView: AnyObject!
    fileprivate let m_cellFont = UIFont.systemFont(ofSize: 13)
    fileprivate var isHorizontal = false
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        self.view.backgroundColor = UIColor.white.withAlphaComponent(0.6)
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.showsVerticalScrollIndicator = false
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.contentInset = UIEdgeInsetsMake(31, 0, 31, 0)
        self.collectionView?.keyboardDismissMode = .interactive
        self.collectionView?.register(PopupCollectionViewCell.self, forCellWithReuseIdentifier: PopupCollectionViewCell.cellID)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return m_optionList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopupCollectionViewCell.cellID, for: indexPath) as! PopupCollectionViewCell
        
        if isHorizontal {
            cell.title.text = nil
        } else {
            cell.title.attributedText = m_optionList[indexPath.row]
        }
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 0
        var width: CGFloat = 0
        
        if isHorizontal {
            width = 44
        } else {
            width = view.frame.width
        }
        
        return CGSize(width: width, height: 44)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: view.frame.width, height: 44)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        dismiss(animated: false) {
            if let completion = self.m_completion {
                completion(indexPath.row)
            }
        }
    }

}

extension PopupCollectionViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for PC: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func prepareForPopoverPresentation(_ popoverPresentationController: UIPopoverPresentationController) {
        popoverPresentationController.permittedArrowDirections = .up
        if let barButtonItem = m_anchorView as? UIBarButtonItem {
            popoverPresentationController.barButtonItem = barButtonItem
        } else {
            popoverPresentationController.sourceView = m_anchorView as? UIView
            popoverPresentationController.sourceView?.backgroundColor = UIColor.clear
            popoverPresentationController.sourceRect = CGRect(x: m_anchorView.frame.size.width/2, y: m_anchorView.frame.height/2, width: 0, height: 0)
        }
        
        popoverPresentationController.backgroundColor = UIColor.clear
        popoverPresentationController.containerView?.backgroundColor = UIColor.clear
    }

}

extension PopupCollectionViewController {

    static func createPopover(optionList data: [String], sender: AnyObject, insets: UIEdgeInsets, isHorizontal: Bool = false, completion: ((Int) -> Void)? = nil) -> PopupCollectionViewController {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let controller = PopupCollectionViewController(collectionViewLayout: layout)
        controller.m_completion = completion
        controller.isHorizontal = isHorizontal
        controller.modalPresentationStyle = .custom
        controller.collectionView?.contentInset = insets
        var maxWidth = UIScreen.main.bounds.width
    
        data.forEach { string in
            let stringAttribute = NSAttributedString(string: string, attributes: [NSAttributedStringKey.font: controller.m_cellFont])
            controller.m_optionList.append(stringAttribute)
            let width = stringAttribute.size().width
            maxWidth = maxWidth > width ? maxWidth : width
        }
        controller.preferredContentSize.width = maxWidth + 40

        if data.count == 1 {
            controller.preferredContentSize.height = 43
        } else {
            controller.preferredContentSize.height = (POPUP_CELL_HEIGHT + 1) * CGFloat(data.count) - 1
        }

        controller.m_anchorView = sender

        return controller
    }

    func presentInViewController(_ controller: UIViewController) {
        popoverPresentationController?.delegate = self
        controller.present(self, animated: false) {
            DispatchQueue.main.async { () -> Void in
                self.popoverPresentationController?.passthroughViews = nil
            }
        }
    }

}
