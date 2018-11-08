//
//  BiscuitDismissController.swift
//  BisKit
//
//  Created by Nicola on 02/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

class BiscuitDismissController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let source = transitionContext.viewController(forKey: .from) as? BiscuitViewController
            else {
                return
        }
        
        let duration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration + 1.0, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
            source.biscuitView.transform = CGAffineTransform(translationX: 0, y: source.topConstraint.constant - 50.0)
        }, completion: { completed in
            transitionContext.completeTransition(completed)
        })
    }
    

}
