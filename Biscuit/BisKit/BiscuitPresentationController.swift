//
//  BiscuitPresentationController.swift
//  BisKit
//
//  Created by Nicola on 01/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

final class BiscuitPresentationController: UIPresentationController {

    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(x: 0, y: 0, width: 180, height: 54)
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
    }
}
