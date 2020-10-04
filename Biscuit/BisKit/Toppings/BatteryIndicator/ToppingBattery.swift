//
//  ToppingBattery.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 02/11/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class ToppingBattery: UIView {
    
    private let label: UILabel = UILabel()
    private let indicator: BatteryIndicator = BatteryIndicator()
    
    public var level: CGFloat = 0.3 {
        didSet {
            self.restoreLevel()
        }
    }
    
    public var state: BatteryState = .normal {
        didSet {
            self.indicator.state = self.state
        }
    }
    
    public init(level: CGFloat, batteryState: BatteryState) {
        super.init(frame: .zero)
        
        self.state = batteryState
        self.level = level
        
        self.commonInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        self.label.textColor = .biskitSecondaryTextColor
        self.label.textAlignment = .right
        
        self.addSubview(label)
        self.addSubview(indicator)
        restoreLevel()
    }
    
    private func restoreLevel() {
        self.indicator.state = self.state
        self.indicator.level = self.level
        self.label.text = "\(Int(self.level*100))%"
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        self.label.frame = CGRect(x: 0, y: 0, width: self.frame.size.width / 2 - 2, height: self.frame.size.height)
        self.indicator.frame = CGRect(x: self.frame.size.width / 2 + 2, y: (self.frame.size.height - self.indicator.frame.size.height) / 2, width: self.indicator.frame.size.width, height: self.indicator.frame.size.height)
    }
    
    
}

extension ToppingBattery : Toppable {
    
    public var intrinsicHeight: CGFloat {
        get {
            return 20
        }
    }
    
    public var relativeView: UIView {
        return self
    }
    
    public func layout(for width: CGFloat) {
        
    }
    
    
    
    
}
