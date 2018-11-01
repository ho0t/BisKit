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
    private var timeout = 0.0
    
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
        
        let height: CGFloat = 64.0
        topConstraint = biscuitView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -height - 30.0)
        
        NSLayoutConstraint.activate([
            topConstraint,
            biscuitView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            biscuitView.widthAnchor.constraint(equalToConstant: 200.0),
            biscuitView.heightAnchor.constraint(equalToConstant: height)
            ])
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.topConstraint.constant = 20.0
        self.biscuitView.alpha = 0.0
        
        UIView.animate(withDuration: 0.75, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            self.biscuitView.alpha = 1.0
        }) { (completed) in
            self.perform(#selector(self.dismissWithAnimation), with: nil, afterDelay: self.timeout)
        }
        
        //should call cancelPreviousPerformRequestsWithTarget if dismissal gestures are allowed
        
    }
    
    @objc func dismissWithAnimation() {
        
        self.topConstraint.constant = -150.0
        
        UIView.animate(withDuration: 0.75, delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 1.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            self.view.isHidden = true
            self.dismiss(animated: false, completion: nil)
        }
        
    }
    
}
