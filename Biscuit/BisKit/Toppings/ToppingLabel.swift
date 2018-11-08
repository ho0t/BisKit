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
        self.text = text
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    
    private func commonInit() {
        self.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.textColor = UIColor.lightGray
        self.lineBreakMode = .byWordWrapping
        self.textAlignment = .center
        
        self.numberOfLines = 0
    }
    

}


// MARK: Toppable
extension ToppingLabel: Toppable {
    
    public var intrinsicHeight: CGFloat {
        get {
            return self.desiredHeight
        }
    }
    
    public func layout(for width: CGFloat) {
        guard let txt = self.text else {
            self.desiredHeight = 10
            return
        }
        
        let size = txt.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [
            NSAttributedString.Key.font : self.font
            ], context: nil)
        self.desiredHeight = size.height
    }
    
    
    public var relativeView: UIView {
        return self
    }
    
}
