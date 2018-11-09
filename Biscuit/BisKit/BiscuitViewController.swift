//
//  BiscuitViewController.swift
//  BisKit
//
//  Created by Nicola on 05/11/18.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit

public class BiscuitViewController: UIViewController {
    
    internal var topConstraint: NSLayoutConstraint!
    internal var heightConstraint: NSLayoutConstraint?
    internal var titleLabel: UILabel = UILabel()
    internal var state: State = .closed
    internal let biscuitView = BiscuitView()
    
    public var automaticallyOpens: Bool = true
    public var autoOpenTimeout: Double = 0.25
    public var automaticallyDismiss: Bool = true
    
    // Private Properties
    internal var timeout: Double = 1.5
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
        self.timeout = timeout
        self.automaticallyDismiss = true
        self.commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.toppingsHandler = ToppingsVisualHandler(biscuit: self, toppings: self.toppings)
        self.modalPresentationStyle = .custom
        self.view.backgroundColor = .clear
        self.transitioningDelegate = self
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setupDesign()
    }
    
    internal func setupDesign() {
        self.heightConstraint = biscuitView.heightAnchor.constraint(equalToConstant: State.closed.biscuitHeight)
        self.view.addSubview(biscuitView)
        
        self.topConstraint = biscuitView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
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
        
        
        self.toppingsHandler.transition(to: .closed, animated: false)
    }
    
    internal func calculateTopConstraint() {
        self.topConstraint.constant = -(self.heightConstraint?.constant ?? 0) - 20.0
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.calculateTopConstraint()
        
        if self.automaticallyOpens {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.autoOpenTimeout) {
                self.toppingsHandler.transition(to: .open, animated: true)
            }
        }
        
        if self.automaticallyDismiss {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.timeout) {
                self.dismiss(animated: true, completion: {
                    
                })
            }
        }
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.toppingsHandler.fixFrames(animated: self.parent != nil)
    }
    
}
