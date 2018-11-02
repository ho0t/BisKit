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
//        let label = ToppingLabel.init(text: "Hello Everyone!")
        let percentage = ToppingBattery(level: 0.5, batteryState: .charging)
        
//        let button = ToppingButton.init(text: "Ciao")
        
        let toppings: [Toppable] = [percentage]
        let biscuit = BiscuitViewController(title: "Apple Pencil", toppings: toppings)
        self.present(biscuit, animated: false, completion: nil)
        
        
    }

}

