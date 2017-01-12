//
//  Standard.swift
//  Effects
//
//  Created by Aaron Connolly on 10/30/16.
//  Copyright © 2016 Top Turn Software. All rights reserved.
//

import UIKit
import Foundation

extension CGRect {
    func randomPointInside() -> CGPoint {
        let x = CGFloat(arc4random_uniform(UInt32(self.width)) + 1)
        let y =  CGFloat(arc4random_uniform(UInt32(self.height)) + 1)
        return CGPoint(x: x, y: y)
    }
}

extension CGPoint {

}

protocol FancyAnimatable {
    func runAnimations()
}
