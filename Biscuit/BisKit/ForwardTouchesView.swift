//
//  ForwardTouchesView.swift
//  BisKit
//
//  Created by Giovanni Filaferro on 08/11/2018.
//  Copyright © 2018 ho0t. All rights reserved.
//

import UIKit


public class ForwardTouchesView: UIView {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
        
        print("ciao")
        guard let res = self.next else {
            return
        }
        res.touchesBegan(touches, with: event)
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesEnded(touches, with: event)
        print("ciao1")
        guard let res = self.next else {
            return
        }
        res.touchesEnded(touches, with: event)
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        print("ciao2")
        guard let res = self.next else {
            return
        }
        res.touchesMoved(touches, with: event)
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        print("ciao3")
        guard let res = self.next else {
            return
        }
        res.touchesCancelled(touches, with: event)
    }
//
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        return self
//    }
//
//    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print("point")
//        return true
//    }
    
}
