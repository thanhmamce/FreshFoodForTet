//
//  GradientSegmentedControl.swift
//  LEORI
//
//  Created by KODAK on 9/8/17.
//  Copyright © 2017 Enthusiastic Team. All rights reserved.
//

import UIKit

protocol GradientSegmentedControlDelegate: class {
    func didSelectSegment(at segment: Int)
}

class GradientSegmentedControl: UIView {
    weak var delegate: GradientSegmentedControlDelegate?
    
    @IBInspectable var firstGradientColor: UIColor = UIColor(0x62E13A) {
        didSet {
//            setupGradient()
        }
    }
    
    @IBInspectable var secondGradientColor: UIColor = UIColor(0x2D1783) {
        didSet {
//            setupGradient()
        }
    }
    
    fileprivate static let defaultColor1: UIColor = UIColor(0x62E13A)//UIColor(0x445566)
    fileprivate static let defaultColor2: UIColor = UIColor(0x2D1783)//UIColor(0x404244)
    fileprivate let defaultColors: [CGColor] = [GradientSegmentedControl.defaultColor1.cgColor, GradientSegmentedControl.defaultColor2.cgColor]
    
    fileprivate var _colors: [CGColor]?
    var colors: [CGColor] {
        get { return _colors ?? defaultColors }
        set (newValue) {
            _colors = newValue
            bubbleView.layer.sublayers?.forEach { ($0 as? CAGradientLayer)?.colors = newValue }
        }
    }
    
    fileprivate var _selectedSegmentIndex: Int = 0
    var selectedSegmentIndex: Int {
        get { return _selectedSegmentIndex }
        set { _selectedSegmentIndex = newValue }
    }
    
    var numberOfIndexes: Int {
        return titles.count
    }
    
    fileprivate var titles: [String] = [String]()
    fileprivate var buttons: [GradientButton] = [GradientButton]()
    fileprivate var lastTrailingConstraint: NSLayoutConstraint?
    
    fileprivate let _bubbleView: UIView = {
        let v = UIView()
        v.layer.borderWidth = 1
        v.layer.cornerRadius = 5
        v.layer.masksToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var bubbleView: UIView {
        return _bubbleView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    fileprivate func setupViews() {
        backgroundColor = .clear
        
        addSubview(bubbleView)
        bubbleView.fill(to: self)
        self.addObserver(self, forKeyPath: "bubbleView.bounds", options: .new, context: nil)
    }
    
    deinit {
        self.removeObserver(self, forKeyPath: "bubbleView.bounds")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bubbleView.bounds" {
            let frame = self.bubbleView.bounds
            do {
                self.bubbleView.layer.borderColor = try UIColor.horizontalGradient(from: firstGradientColor, to: secondGradientColor, width: frame.width).cgColor
            } catch {
                
            }
        }
    }
    
    fileprivate func createButton(withTitle title: String) -> GradientButton {
        let b = GradientButton()
        b.cornerRadius = 5
        b.masksToBounds = true
        b.firstGradientColor = firstGradientColor
        b.secondGradientColor = secondGradientColor
        b.isHorizontalGradient = true
        b.setTitle(title, for: .normal)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(onButtonClicked(_:)), for: .touchUpInside)
        return b
    }
    
    @objc fileprivate func onButtonClicked(_ sender: UIButton) {
        guard sender.tag != selectedSegmentIndex else { return }
        
        let index = sender.tag
        selectSegment(at: index)
        delegate?.didSelectSegment(at: index)
    }
    
    fileprivate func updateStyleForButton(at segment: Int) {
        guard !buttons.isEmpty, segment >= 0, segment < buttons.count else { return }

        let button = buttons[segment]
        if segment == selectedSegmentIndex {
            button.firstGradientColor = firstGradientColor
            button.secondGradientColor = secondGradientColor
            button.setTitleColor(.white, for: .normal)
        } else {
            button.firstGradientColor = .white
            button.secondGradientColor = .white
            button.setTitleColor(.black, for: .normal)
        }
    }
    
    // MARK: ### PUBLIC FUNCTIONS ###
    func titleForSegment(at segment: Int) -> String? {
        guard !titles.isEmpty, segment >= 0, segment < titles.count else { return nil }
        
        return titles[segment]
    }
    
    func insertSegment(withTitle title: String) {
        let lastButton = buttons.last
        
        titles.append(title)
        let newButton = createButton(withTitle: title)
        newButton.tag = buttons.count
        buttons.append(newButton)
        bubbleView.addSubview(newButton)
        
        updateStyleForButton(at: buttons.count-1)
        newButton.top(to: bubbleView, equal: 0).isActive = true
        newButton.bottom(to: bubbleView, equal: 0).isActive = true
        if let lastButton = lastButton {
            lastTrailingConstraint?.isActive = false
            newButton.leading(to: lastButton, withAttribute: .trailing, equal: 0).isActive = true
            newButton.width(equalTo: buttons.first).isActive = true
        } else {
            newButton.leading(to: bubbleView).isActive = true
        }
        lastTrailingConstraint = newButton.trailing(to: bubbleView)
        lastTrailingConstraint?.isActive = true
    }
    
    func setTitle(_ title: String, forSegmentAt segment: Int) {
        guard !titles.isEmpty, segment >= 0, segment < titles.count else { return }

        titles[segment] = title
        buttons[segment].setTitle(title, for: .normal)
    }
    
    // TODO - Implement remove segment functions
    /*
    func removeSegment(at segment: Int) {
        guard !titles.isEmpty, segment >= 0, segment < titles.count else { return }
        
        titles.remove(at: segment)
        buttons[segment].removeFromSuperview()
        buttons.remove(at: segment)
    }
    */
    
    func removeAllSegments() {
        titles.removeAll()
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
    }

//    func removeAllSegments(except segment: Int) {
//        guard 0..<titles.count ~= segment else { return }
//        guard titles.count > 1 else { return }
//        
//        var index = 0
//        while (index < segment) {
//            titles.removeFirst()
//            buttons.first?.removeFromSuperview()
//            buttons.removeFirst()
//            index += 1
//        }
//        
//        while (titles.count > 1) {
//            titles.removeLast()
//            buttons.last?.removeFromSuperview()
//            buttons.removeLast()
//        }
//    }
    
    func selectSegment(at segment: Int) {
        let lastSegment = selectedSegmentIndex
        selectedSegmentIndex = segment
        
        updateStyleForButton(at: lastSegment)
        updateStyleForButton(at: segment)
    }
}
