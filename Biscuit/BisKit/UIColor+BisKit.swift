//
//  UIColor+BisKit.swift
//  BisKit
//
//  Created by Nicola on 04/10/2020.
//  Copyright © 2020 ho0t. All rights reserved.
//

import UIKit

public extension UIColor {
        
    static var biskitPrimaryTextColor = UIColor(named: "primaryTextColor",
                                                in: Bundle(for: BundleToken.self),
                                                compatibleWith: nil)!
    
    static var biskitSecondaryTextColor = UIColor(named: "secondaryTextColor",
                                                  in: Bundle(for: BundleToken.self),
                                                  compatibleWith: nil)!
}

private final class BundleToken {}
