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


    @IBAction func didTapTextBiscuit() {
    
        let label = ToppingLabel(text: "Battery is low.")
        
        let biscuit = BiscuitViewController(title: "My Pencil", toppings: [label], timeout: 1.5)
        self.present(biscuit, animated: true, completion: nil)
    }
    
    @IBAction func didTapBatteryBiscuit() {
        
        let percentage = ToppingBattery(level: 0.5, batteryState: .charging)
        
        let biscuit = BiscuitViewController(title: "My Pencil", toppings: [percentage], timeout: 1.5)
        self.present(biscuit, animated: true, completion: nil)

    }
    
}

