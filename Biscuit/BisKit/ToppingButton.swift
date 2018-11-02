//
//  ToppingButton.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 31/10/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class ToppingButton: UIButton {
    
    fileprivate var desiredHeight: CGFloat = 20
    
    public override var buttonType: UIButton.ButtonType {
        return .roundedRect
    }
    
    public override var tintColor: UIColor! {
        didSet {
            self.setTitleColor(self.tintColor, for: .normal)
            self.setTitleColor(self.tintColor.withAlphaComponent(0.4), for: .highlighted)
        }
    }
    
    public var text: String? {
        didSet {
            if text != nil {
                if !text!.contains("‣") {
                    self.setTitle(text! + " ‣", for: .normal)
                }
                else {
                    self.setTitle(text, for: .normal)
                }
            }
            
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
    
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        guard let txt = self.text else {
            return
        }
        self.text = txt
    }
    
    private func commonInit() {
        let tint = self.tintColor
        self.tintColor = tint
        
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
    }
    
}


// MARK: Toppable Implementation
extension ToppingButton: Toppable {
    
    public var intrinsicHeight: CGFloat {
        get {
            return self.desiredHeight
        }
    }
    
    public func layout(for width: CGFloat) {
        guard let txt = self.text, let label = self.titleLabel else {
            self.desiredHeight = 10
            return
        }
        
        let size = txt.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [
            NSAttributedString.Key.font : label.font
            ], context: nil)
        self.desiredHeight = size.height + 4
    }
    
    public var relativeView: UIView {
        return self
    }
    
}
