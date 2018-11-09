//
//  BiscuitAnimationController.swift
//  BisKit
//
//  Created by Nicola on 01/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

class BiscuitAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let destination = transitionContext.viewController(forKey: .to) as? BiscuitViewController
            else {
                return
        }
        
        let containerView = transitionContext.containerView
        containerView.isUserInteractionEnabled = false
        containerView.addSubview(destination.view)
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.0, options: .curveEaseIn, animations: {
            destination.biscuitView.alpha = 1.0
            destination.biscuitView.transform = CGAffineTransform(translationX: 0, y: -destination.topConstraint.constant)
        }) { completed in
            transitionContext.completeTransition(completed)
        }
    }
}
