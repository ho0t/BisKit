//
//  Toppable.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 31/10/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit


public protocol Toppable {
    
    var intrinsicHeight: CGFloat { get }
    var relativeView: UIView { get }
    
    func layout(for width: CGFloat)
    
}
