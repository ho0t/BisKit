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
    
    private let biscuitView = BiscuitView()
    private var topConstraint: NSLayoutConstraint!
    private var timeout: Double = 0.0
    private lazy var fadeInAnimator = {
        UIViewPropertyAnimator(duration: 0.5, dampingRatio: 1.2) { [unowned self] in
            self.biscuitView.alpha = 1.0
            self.biscuitView.transform = CGAffineTransform(translationX: 0, y: -self.topConstraint.constant)
        }
    }()
    
    private lazy var fadeOutAnimator = {
        UIViewPropertyAnimator(duration: 0.5 + 1.0, dampingRatio: 1.2) { [unowned self] in
            self.biscuitView.transform = CGAffineTransform(translationX: 0, y: self.topConstraint.constant - 50)
        }
    }()
    
    
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
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
        self.view.backgroundColor = .clear
        self.timeout = timeout
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
    }
    
    private func setupDesign() {
        
        self.view.addSubview(biscuitView)
        
        topConstraint = biscuitView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.0)
        calculateTopConstraint()
        
        NSLayoutConstraint.activate([
            topConstraint,
            biscuitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            biscuitView.widthAnchor.constraint(equalToConstant: 200.0),
            biscuitView.heightAnchor.constraint(equalToConstant: 64.0)
            ])
    }
    
    private func calculateTopConstraint() {
        let height: CGFloat = 64.0
        topConstraint.constant = -height - 20.0
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.biscuitView.alpha = 0.0
        
        calculateTopConstraint()
        
        self.fadeInAnimator.addCompletion { [unowned self] _ in
            self.fadeOutAnimator.startAnimation(afterDelay: self.timeout)
        }
        
        self.fadeOutAnimator.addCompletion { [unowned self] _ in
            self.dismiss(animated: false, completion: nil)
        }
        
        self.fadeInAnimator.startAnimation()
        
    }
    
    
}
