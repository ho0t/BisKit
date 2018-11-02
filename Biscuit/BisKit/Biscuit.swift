//
//  Biscuit.swift
//  Biscuit
//
//  Created by Nicola on 31/10/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public protocol Biscuit {
    
    init(text: String, timeout: Double)
    init(toppings: [Toppable], timeout: Double)
}

public class BiscuitViewController: UIViewController, Biscuit {
    
    public let biscuitView = BiscuitView()
    public var topConstraint: NSLayoutConstraint!
    internal var timeout: Double = 0.0
    internal let defaultHeight: CGFloat = 54.0
    
    // Initializers
    
    public required convenience init(text: String, timeout: Double) {
        self.init(toppings: [ToppingLabel(text: text)], timeout: timeout)
    }
    
    public required init(toppings: [Toppable], timeout: Double) {
        super.init(nibName: nil, bundle: nil)
        self.commonInit(timeout: timeout)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(timeout: timeout)
    }
    
    private func commonInit(timeout: Double) {
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = .clear
        self.transitioningDelegate = self
        self.timeout = timeout
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }
    
    internal func setupDesign() {
        
        self.view.addSubview(biscuitView)
        
        topConstraint = biscuitView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
        calculateTopConstraint()
        
        NSLayoutConstraint.activate([
            topConstraint,
            biscuitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            biscuitView.widthAnchor.constraint(equalToConstant: 180.0),
            biscuitView.heightAnchor.constraint(equalToConstant: defaultHeight)
            ])
    }
    
    internal func calculateTopConstraint() {
        topConstraint.constant = -defaultHeight - 20.0
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateTopConstraint()
    }
    
}
