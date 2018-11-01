//
//  BiscuitAnimationController.swift
//  BisKit
//
//  Created by Nicola on 01/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

class BiscuitAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    /*
    internal lazy var fadeInAnimator = {
        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1.2) { [unowned self] in
            self.biscuitView.alpha = 1.0
            self.biscuitView.transform = CGAffineTransform(translationX: 0, y: -self.topConstraint.constant)
        }
    }()
    
    internal lazy var fadeOutAnimator = {
        UIViewPropertyAnimator(duration: 0.5 + 1.0, dampingRatio: 1.2) { [unowned self] in
            self.biscuitView.transform = CGAffineTransform(translationX: 0, y: self.topConstraint.constant - 50)
        }
    }()
    */
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to) as? BiscuitViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: destination)
        
        containerView.addSubview(destination.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            destination.biscuitView.alpha = 1.0
            destination.biscuitView.transform = CGAffineTransform(translationX: 0, y: -destination.topConstraint.constant)
        }) { completed in
            DispatchQueue.main.asyncAfter(deadline: .now() + destination.timeout) {
                destination.dismiss(animated: true, completion: {
                })
                transitionContext.completeTransition(completed)
            }
            //
        }
        
        // Add animations here
        /*
        self.fadeInAnimator.addCompletion { [unowned self] _ in
            self.fadeOutAnimator.startAnimation(afterDelay: self.timeout)
        }
        
        self.fadeOutAnimator.addCompletion { [unowned self] _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        self.fadeInAnimator.startAnimation()*/
    }
}
