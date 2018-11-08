//
//  BatteryIndicator.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 02/11/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public enum BatteryState {
    case normal
    case charging
    
    internal func imageName() -> String {
        if self == .normal {
            return "battery"
        }
        return "battery_charging"
    }
}

class BatteryIndicator: UIView {
    
    private var imageView: UIImageView = UIImageView()
    private var levelView: UIView = UIView()
    
    public var level: CGFloat = 0.3 {
        didSet {
            self.restoreLevel()
        }
    }
    
    public var state: BatteryState = .normal {
        didSet {
            self.restoreLevel()
        }
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 12))
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(frame: CGRect(x: 0, y: 0, width: 25, height: 12))
        self.commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        
        self.imageView.tintColor = UIColor.gray
        self.imageView.contentMode = .scaleToFill
        
        self.levelView.layer.cornerRadius = 1.5
        
        self.addSubview(levelView)
        self.addSubview(imageView)
        
        restoreLevel()
    }
    
    private func restoreLevel() {
        guard self.level >= 0 && self.level <= 1 else {
            return
        }
        
        let maxWidth = self.frame.size.width - 2.5 - 5.5
        var w = maxWidth * self.level
        w = w < 2 ? 2 : w
        self.levelView.frame = CGRect(x: 2.5, y: 2.5, width: w, height: self.frame.size.height - 5)
        
        if self.level < 0.2 {
            self.levelView.backgroundColor = #colorLiteral(red: 0.8545438647, green: 0.2995099723, blue: 0.3087605372, alpha: 1)
        }
        else {
            self.levelView.backgroundColor = #colorLiteral(red: 0.2995099723, green: 0.8545438647, blue: 0.3975897431, alpha: 1)
        }
        
        let bundle = Bundle(for: BatteryIndicator.self)
        let img = UIImage(named: self.state.imageName(), in: bundle, compatibleWith: nil)
        self.imageView.image = img
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imageView.frame = self.bounds
        self.restoreLevel()
    }
    
}
