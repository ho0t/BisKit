//
//  ViewController.swift
//  Biscuit
//
//  Created by Giovanni Filaferro on 31/10/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit
import BisKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let label = ToppingLabel.init(text: "Hello Everyonhgj gjjkgjkg jkgkg kgkgk k gk  ke!")
        
        let toppings = [label]
        let biscuit = BiscuitViewController(title: "Apple Pencil", toppings: toppings)
        self.present(biscuit, animated: false, completion: nil)
        
        
    }

}

