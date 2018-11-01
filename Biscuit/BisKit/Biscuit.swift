//
//  Biscuit.swift
//  Biscuit
//
//  Created by Nicola on 31/10/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class BiscuitViewController: UIViewController {
    
    // Private Properties
    private var toppings: [Toppable] = [Toppable]()
    public var toppingInsets: UIEdgeInsets = UIEdgeInsets.init(top: 10, left: 20, bottom: 10, right: 20) {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    public var titlePadding: CGFloat = 2 {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    public var elementPadding: CGFloat = 1 {
        didSet {
            self.view.setNeedsLayout()
        }
    }
    
    private let biscuitBackground = BiscuitView()
    private var biscuitHeight: NSLayoutConstraint?
    private var contentAnimator: UIViewPropertyAnimator = UIViewPropertyAnimator()
    
    public var titleLabel: UILabel = UILabel()
    
    
    
    enum State: Int {
        case open
        case closed
        
        func biscuitHeight() -> CGFloat {
            if self == .closed {
                return 50
            }
            return State.automaticDimension
        }
        
        func titleHeight() -> CGFloat {
            if self == .closed {
                return self.biscuitHeight()
            }
            return 15.0
        }
        
        func titleFont() -> UIFont {
            if self == .open {
                return UIFont.systemFont(ofSize: 12, weight: .medium)
            }
            return UIFont.systemFont(ofSize: 14, weight: .medium)
        }
        
        func canTransition(to: State) -> Bool {
            return to.rawValue != self.rawValue
        }
        
        static var automaticDimension: CGFloat = CGFloat(MAXFLOAT)
    }
    private(set) var state: State = .closed
    
    // Initializers
    public required init(title: String, toppings: [Toppable] = []) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.toppings = toppings
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = .clear
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupDesign()
    }

    private func setupDesign() {
        self.biscuitHeight = self.biscuitBackground.heightAnchor.constraint(equalToConstant: State.closed.biscuitHeight())
        self.view.addSubview(self.biscuitBackground)
        
        NSLayoutConstraint.activate([
            self.biscuitBackground.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            self.biscuitBackground.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.biscuitBackground.widthAnchor.constraint(equalToConstant: 160),
            self.biscuitHeight!
            ])
        
        updateViewConstraints()
        
        
        
        // Title and Content Animator
//        let timing = UISpringTimingParameters(dampingRatio: 0.8, initialVelocity: CGVector(dx: 0.1, dy: 0.1))
        let params = UICubicTimingParameters(animationCurve: .easeIn)
        self.contentAnimator = UIViewPropertyAnimator(duration: 0, timingParameters: params)
        
        self.titleLabel.font = self.state.titleFont()
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.textAlignment = .center
        self.biscuitBackground.addSubview(self.titleLabel)
        
        self.view.setNeedsLayout()
        
        
        self.transition(to: .closed, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.transition(to: .open, animated: true)
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.transition(to: .closed, animated: true)
//        }
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.fixFrames(animated: self.parent != nil)
    }
    
    
    
    // Toppings Calculations
    
    private func transition(to: State, animated: Bool) {
        guard self.state.canTransition(to: to) else {
            self.fixFrames(for: to, animated: animated, animateRepositioning: true)
            return
        }
        
        self.fixFrames(for: to, animated: animated, animateRepositioning: false)
    }
    
    private func fixFrames(animated: Bool) {
        self.fixFrames(for: self.state, animated: animated)
    }
    
    private func fixFrames(for state: State, animated: Bool, animateRepositioning: Bool = true) {
        if animated {
            self.contentAnimator.stopAnimation(true)
        }
        
        self.state = state
        if animateRepositioning && animated {
            self.contentAnimator.addAnimations {
                self.repositionToppings()
            }
        }
        else {
            self.repositionToppings()
        }
        
        
        let block = {
            self.titleLabel.font = state.titleFont()
            
            if state == .open && self.toppings.count > 0 {
                
                
                self.titleLabel.frame = CGRect(x: self.toppingInsets.left, y: self.toppingInsets.top, width: self.biscuitBackground.frame.size.width - self.toppingInsets.left - self.toppingInsets.right, height: state.titleHeight())
                
                
                var finalHeight: CGFloat = self.titleLabel.frame.size.height + self.toppingInsets.top + self.titlePadding
                
                for top in self.toppings {
                    top.relativeView.alpha = 1.0
                    top.relativeView.transform = CGAffineTransform.identity
                    finalHeight += top.intrinsicHeight
                    
                    if top.relativeView != self.toppings.last!.relativeView {
                        finalHeight += self.elementPadding
                    }
                }
                
                finalHeight += self.toppingInsets.bottom
                
                self.biscuitHeight?.constant = finalHeight
                
            }
            else {
                // Just show title
                self.titleLabel.frame = CGRect(x: self.toppingInsets.left, y: 0, width: self.biscuitBackground.frame.size.width - self.toppingInsets.left - self.toppingInsets.right, height: self.biscuitBackground.frame.size.height)
                
                for top in self.toppings {
                    top.relativeView.alpha = 0.0
                    top.relativeView.transform = CGAffineTransform.init(translationX: 0, y: -10)
                }
                
                self.biscuitHeight?.constant = State.closed.biscuitHeight()
            }
        }
        
        if animated {
            self.contentAnimator.addAnimations {
                block()
            }
            
            self.contentAnimator.startAnimation()
        }
        else {
            block()
        }
        
    }
    
    private func repositionToppings() {
        guard self.toppings.count > 0 else {
            return
        }
        
        var height: CGFloat = State.open.titleHeight() + self.toppingInsets.top + self.titlePadding
        let width = self.biscuitBackground.frame.size.width - self.toppingInsets.left - self.toppingInsets.right
        
        
        for top in self.toppings {
            
            // Recalculate
            top.layout(for: width)
            
            // Fix Frames
            if top.relativeView.superview == nil {
                self.biscuitBackground.addSubview(top.relativeView)
                top.relativeView.alpha = 0.0
                top.relativeView.transform = CGAffineTransform.init(translationX: 0, y: -10)
            }
            
            let newFrame = CGRect(x: self.toppingInsets.left, y: height, width: width, height: top.intrinsicHeight)
            top.relativeView.frame = newFrame
            
            height += top.intrinsicHeight
            
            if self.toppings.last!.relativeView != top.relativeView {
                height += self.elementPadding
            }
        }
        
        
    }
    
}
