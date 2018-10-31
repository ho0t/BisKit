//
//  Poppo.swift
//  Poppo
//
//  Created by Nicola on 31/10/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public protocol Poppable where Self: UIView {
    
}

public protocol Poppo {
    
    init(text: String)
    init(elements: [Poppable])
}

public class PoppoViewController: UIViewController, Poppo {
    
    // Initializers
    
    public required init(text: String) {
        super.init(nibName: nil, bundle: nil)
        self.commonInit()
    }
    
    public required init(elements: [Poppable]) {
        super.init(nibName: nil, bundle: nil)
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = .clear
    }
    
    private let poppoView = PoppoView()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }

    private func setupDesign() {
        
        self.view.addSubview(poppoView)
        
        NSLayoutConstraint.activate([
            poppoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20.0),
            poppoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            poppoView.widthAnchor.constraint(equalToConstant: 200.0),
            poppoView.heightAnchor.constraint(equalToConstant: 64.0)
            ])
        
        updateViewConstraints()
        
        self.view.setNeedsLayout()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
}
