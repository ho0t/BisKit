//
//  ToppingsVisualHandler.swift
//  BisKit
//
//  Created by Nicola on 05/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class ToppingsVisualHandler: NSObject {
    
    private var biscuit: BiscuitViewController!
    private var toppings: [Toppable]!
    private var contentAnimator = UIViewPropertyAnimator()
    
    init(biscuit: BiscuitViewController, toppings: [Toppable]) {
        self.biscuit = biscuit
        self.toppings = toppings
        
        // Title and Content Animator
        let params = UICubicTimingParameters(animationCurve: .easeIn)
        self.contentAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: params)
    }

    public var toppingInsets: UIEdgeInsets = UIEdgeInsets.init(top: 7, left: 20, bottom: 7, right: 20) {
        didSet {
            self.biscuit.view.setNeedsLayout()
        }
    }
    
    public var titlePadding: CGFloat = 0 {
        didSet {
            self.biscuit.view.setNeedsLayout()
        }
    }
    public var elementPadding: CGFloat = 0 {
        didSet {
            self.biscuit.view.setNeedsLayout()
        }
    }
    
    // Toppings Calculations
    
    public func transition(to: State, animated: Bool) {
        guard biscuit.state.canTransition(to: to) else {
            self.fixFrames(for: to, animated: animated, animateRepositioning: true)
            return
        }
        
        self.fixFrames(for: to, animated: animated, animateRepositioning: false)
    }
    
    public func fixFrames(animated: Bool) {
        self.fixFrames(for: biscuit.state, animated: animated)
    }
    
    private func fixFrames(for state: State, animated: Bool, animateRepositioning: Bool = true) {
        if animated {
            self.contentAnimator.stopAnimation(true)
        }
        
        self.biscuit.state = state
        
        if animateRepositioning && animated {
            self.contentAnimator.addAnimations {
                self.repositionToppings()
            }
        } else {
            self.repositionToppings()
        }
        
        let block = {
            self.biscuit.titleLabel.font = state.titleFont
            
            if state == .open && self.toppings.count > 0 {
                
                let computedWidth = self.biscuit.biscuitView.frame.size.width - self.toppingInsets.left - self.toppingInsets.right
                
                self.biscuit.titleLabel.frame = CGRect(x: self.toppingInsets.left,
                                                       y: self.toppingInsets.top,
                                                       width: computedWidth,
                                                       height: state.titleHeight)
                
                var finalHeight: CGFloat = self.biscuit.titleLabel.frame.size.height + self.toppingInsets.top + self.titlePadding
                
                for topping in self.toppings {
                    topping.relativeView.alpha = 1.0
                    topping.relativeView.transform = CGAffineTransform.identity
                    finalHeight += topping.intrinsicHeight
                    
                    if topping.relativeView != self.toppings.last!.relativeView {
                        finalHeight += self.elementPadding
                    }
                }
                
                finalHeight += self.toppingInsets.bottom
                
                self.biscuit.heightConstraint?.constant = finalHeight
                
            }
            else {
                // Just show title
                
                let computedWidth = self.biscuit.biscuitView.frame.size.width - self.toppingInsets.left - self.toppingInsets.right
                self.biscuit.titleLabel.frame = CGRect(x: self.toppingInsets.left,
                                                       y: 0,
                                                       width: computedWidth,
                                                       height: self.biscuit.biscuitView.frame.size.height)
                
                for topping in self.toppings {
                    topping.relativeView.alpha = 0.0
                    topping.relativeView.transform = CGAffineTransform.init(translationX: 0, y: 0)
                }
                
                self.biscuit.heightConstraint?.constant = State.closed.biscuitHeight
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
        
        var height: CGFloat = State.open.titleHeight + self.toppingInsets.top + self.titlePadding
        let width = self.biscuit.biscuitView.frame.size.width - self.toppingInsets.left - self.toppingInsets.right
        
        self.toppings.forEach { topping in
            
            // Recalculate
            topping.layout(for: width)
            
            // Fix Frames
            if topping.relativeView.superview == nil {
                self.biscuit.biscuitView.addSubview(topping.relativeView)
                topping.relativeView.alpha = 0.0
                topping.relativeView.transform = CGAffineTransform.init(translationX: 0, y: -5)
            }
            
            let newFrame = CGRect(x: self.toppingInsets.left, y: height, width: width, height: topping.intrinsicHeight)
            topping.relativeView.frame = newFrame
            
            height += topping.intrinsicHeight
            
            if self.toppings.last!.relativeView != topping.relativeView {
                height += self.elementPadding
            }
        }
    }
    
}
