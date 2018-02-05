//
//  BasePagesViewController.swift
//  LEORI
//
//  Created by THANH on 9/29/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

@objc protocol BasePagesViewInterface: class {
    func move(to page: Int)
    func append(_ page: UIViewController)
}

protocol BasePagesViewControllerDelegate: class {
    func pageViewControllerWillChangePage()
    func pageViewControllerDidChange(to page: Int)
}

extension BasePagesViewControllerDelegate {
    func pageViewControllerDidChange(to page: Int) {}
}

class BasePagesViewController: UIPageViewController {
    var basePresenter: BasePresenterInterface?
    weak var pageDelegate: BasePagesViewControllerDelegate?
    
    fileprivate var _orderedViewControllers = [UIViewController]()
    internal var orderedViewControllers: [UIViewController] {
        return _orderedViewControllers
    }
    
    fileprivate var _currentPageIndex: Int = 0
    internal var currentPageIndex: Int {
        return _currentPageIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareViewControllers()
        self.preparePageController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    internal func prepareViewControllers() {
        _orderedViewControllers.removeAll()
    }
    
    fileprivate func preparePageController() {
//        self.dataSource = self
        self.delegate = self
    }
}
extension BasePagesViewController: BasePagesViewInterface {
    func move(to page: Int) {
        guard 0..<_orderedViewControllers.count ~= page else { return }
        
        let viewController = _orderedViewControllers[page]
        
        let direction: UIPageViewControllerNavigationDirection = (page > _currentPageIndex) ? .forward : .forward
        self.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
        _currentPageIndex = page
    }
    
    func moveNext() {
        _currentPageIndex += 1
        let viewController = _orderedViewControllers[_currentPageIndex]
        
        let direction: UIPageViewControllerNavigationDirection = .forward
        self.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    
    func moveBack() {
        _currentPageIndex -= 1
        let viewController = _orderedViewControllers[_currentPageIndex]
        
        let direction: UIPageViewControllerNavigationDirection = .reverse
        self.setViewControllers([viewController], direction: direction, animated: true, completion: nil)
    }
    
    func append(_ page: UIViewController) {
        _orderedViewControllers.append(page)
    }
    
    func showLoadingView() { }
    func showLoadingView(withMessage message: String?) {}
    func hideLoadingView() {}
    func hideLoadingView(onCompletion: (() -> Void)?) {}
    func setLoadingMessage(_ message: String?) {}
    func showAlert(withTitle title:String?, message mes: String?) {}
    func showAlert(withTitle title:String?, message mes: String?, completeHandler handle: @escaping (AnyObject?) -> Void) {}
    func showAlertConfirm(withTitle title: String?, meesage mes: String?, didCancel cancleClosure: @escaping (AnyObject?) -> Void, didConfirm comfirmClosure: @escaping (AnyObject?) -> Void) {}
}

extension BasePagesViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = _orderedViewControllers.index(of: viewController), index >= 0 else { return nil }
        
        return _orderedViewControllers[(index + 2)%3]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = _orderedViewControllers.index(of: viewController), index <= _orderedViewControllers.count-1 else { return nil }
        
        return _orderedViewControllers[(index + 1)%3]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            if let viewController = pageViewController.viewControllers?[0] {
                if let index = _orderedViewControllers.index(of: viewController) {
                    _currentPageIndex = index
                    self.pageDelegate?.pageViewControllerDidChange(to: index)
                }
            }
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        self.pageDelegate?.pageViewControllerWillChangePage()
    }
}

extension UIPageViewController {
    var alwaysBounceHorizontal: Bool {
        get {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    return subView.alwaysBounceHorizontal
                }
            }
            return true
        }
        set {
            for view in view.subviews {
                if let subView = view as? UIScrollView {
                    subView.alwaysBounceHorizontal = newValue
                }
            }
        }
    }
}
