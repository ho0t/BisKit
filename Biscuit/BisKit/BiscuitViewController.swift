//
//  BiscuitViewController.swift
//  BisKit
//
//  Created by Nicola on 05/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class BiscuitViewController: UIViewController {
    
    public var topConstraint: NSLayoutConstraint!
    public var heightConstraint: NSLayoutConstraint?
    public var titleLabel: UILabel = UILabel()
    public var state: State = .closed
    public let biscuitView = BiscuitView()
 
    // Private Properties
    internal var timeout: Double = 0.0
    private var toppings: [Toppable] = [Toppable]()
    private var toppingsHandler: ToppingsVisualHandler!
    
    // Initializers
    
    public required convenience init(title: String, timeout: Double) {
        self.init(title: title, toppings: [], timeout: timeout)
    }
    
    public required init(title: String, toppings: [Toppable] = [], timeout: Double) {
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.toppings = toppings
        self.commonInit(timeout: timeout)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit(timeout: timeout)
    }
    
    
    private func commonInit(timeout: Double) {
        self.toppingsHandler = ToppingsVisualHandler(biscuit: self, toppings: self.toppings)
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = .clear
        self.transitioningDelegate = self
        self.timeout = timeout
    }
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupDesign()
    }
    
    internal func setupDesign() {
        
        self.heightConstraint = biscuitView.heightAnchor.constraint(equalToConstant: State.closed.biscuitHeight)
        self.view.addSubview(biscuitView)
        
        topConstraint = biscuitView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
        calculateTopConstraint()
        
        NSLayoutConstraint.activate([
            topConstraint,
            biscuitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            biscuitView.widthAnchor.constraint(equalToConstant: 160.0),
            self.topConstraint,
            self.heightConstraint!
            ])
        
        updateViewConstraints()
        
        self.titleLabel.font = state.titleFont
        self.titleLabel.textColor = UIColor.black
        self.titleLabel.textAlignment = .center
        self.biscuitView.addSubview(self.titleLabel)
        
        self.view.setNeedsLayout()
        
        toppingsHandler.transition(to: .closed, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.toppingsHandler.transition(to: .open, animated: true)
        }
    }
    
    internal func calculateTopConstraint() {
        topConstraint.constant = -(self.heightConstraint?.constant ?? 0) - 20.0
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        calculateTopConstraint()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        toppingsHandler.fixFrames(animated: self.parent != nil)
    }
    
}
