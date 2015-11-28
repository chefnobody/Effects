//
//  TTStarfieldView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/27/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

@IBDesignable
public class TTStarfieldView: UIView {
    
    @IBInspectable var dotCount: UInt32 = 1000
    @IBInspectable var maxAnimationDuration: UInt32 = 30
    
    var dotSize: CGFloat = 2.0
    
    // MARK:- Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // IBInspectable?
        let squareColor = UIColor.whiteColor()
        
        // insert view rect so stars can appear as though they're coming from off-screen
        let offsetRect = CGRectInset(self.frame, -20, -20)
        let minX = CGRectGetMinX(offsetRect)
        let maxX = CGRectGetMaxX(offsetRect)
        let height = CGRectGetHeight(offsetRect)
        let fillMode = kCAFillModeBoth
        
        for i in 1...self.dotCount {
            
            // fixed x positions
            let xFrom: CGFloat = minX
            let xTo: CGFloat = maxX
            
            // random Y, begin times and durations
            let randomYFrom: CGFloat = CGFloat(arc4random_uniform(UInt32(height)) + 1)
            let randomYTo: CGFloat = CGFloat(arc4random_uniform(UInt32(height)) + 1)
            let randomDuration = Double(arc4random_uniform(maxAnimationDuration) + 1)
            let randomBeginTime = Double(arc4random_uniform(self.dotCount) + 1)
            
            // ratio of random duration (speed of animation) to the total length of duration
            let beginTimeDurationFactor = randomDuration/Double(maxAnimationDuration)
            
            // 1 is the smallest size, 20 the largest
            let squareSize = 10 - CGFloat(10 * beginTimeDurationFactor) // subtract from 10 to flip it.
            
            // create new layer
            let layer = CALayer()
            layer.bounds = CGRectMake(0, 0, squareSize, squareSize)
            layer.position = CGPointMake(xFrom, randomYFrom)
            layer.backgroundColor = squareColor.CGColor
            
            // x animation
            let animationX = CABasicAnimation()
            animationX.keyPath = "position.x"
            animationX.fromValue = xFrom
            animationX.toValue = xTo
            animationX.duration = randomDuration
            animationX.fillMode = fillMode
            animationX.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
            
            // add layer as sublayer
            self.layer.addSublayer(layer)
            
            // add animations
            layer.addAnimation(animationX, forKey: ("movement-animation-x-\(i)"))
            
            // set layer's final position
            layer.position = CGPointMake(xTo, randomYTo)
        }
    }
    
    func setup() {
        self.backgroundColor = UIColor.blackColor()
        
    }
}