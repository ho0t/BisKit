//
//  ToppingLabel.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 31/10/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class ToppingLabel: UILabel {
    
    fileprivate var desiredHeight: CGFloat = 20
    
    public override var text: String? {
        didSet {
            self.layout(for: self.frame.size.width)
        }
    }
    
    public init(text: String) {
        super.init(frame: .zero)
        self.commonInit()
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    private func commonInit() {
        self.font = UIFont.preferredFont(forTextStyle: .callout)
        self.textColor = UIColor.lightGray
        
    }
    
}


extension ToppingLabel: Topping {
    
    public var intrinsicHeight: CGFloat {
        get {
            return self.desiredHeight
        }
        set {
            self.desiredHeight = self.intrinsicHeight
        }
    }
    
    
    
    public func layout(for width: CGFloat) {
        guard let txt = self.text else {
            return
        }
        
        let size = txt.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [
            NSAttributedString.Key.font : self.font
            ], context: nil)
        self.desiredHeight = size.height
    }
    
    
    
    
}
