//
//  BiscuitViewController+Transitioning.swift
//  BisKit
//
//  Created by Nicola on 01/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

extension BiscuitViewController: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BiscuitAnimationController()
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BiscuitDismissController()
    }
    
}
