//
//  BiscuitView.swift
//  Biscuit
//
//  Created by Nicola on 31/10/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class BiscuitView: UIView {

    private var effectView: UIVisualEffectView! = nil
    private var shadowLayer: CAShapeLayer! = nil
    
    public init() {
        super.init(frame: .zero)
        setupDesign()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDesign()
    }
    
    func setupDesign() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let effect = UIBlurEffect(style: .extraLight)
        effectView = UIVisualEffectView(effect: effect)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 25.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.2).cgColor
        
        self.addSubview(effectView)
        
        NSLayoutConstraint.activate([
            effectView.topAnchor.constraint(equalTo: topAnchor),
            effectView.bottomAnchor.constraint(equalTo: bottomAnchor),
            effectView.leadingAnchor.constraint(equalTo: leadingAnchor),
            effectView.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = min(bounds.size.height / 2.0, 32.0)
        effectView.layer.cornerRadius = min(bounds.size.height / 2.0, 32.0)
        effectView.layer.masksToBounds = true
    }
    

}
