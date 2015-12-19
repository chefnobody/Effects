//
//  FireworksView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/27/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

@IBDesignable
public class FireworksView: UIView {
    
    @IBInspectable var dotSize: CGFloat = 5.0
    @IBInspectable var dotCount: Int = 1000
    @IBInspectable var animationDuration: Double = 10.0
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // offset main view rect by 200 on all sides so dots will come from off-screen sometimes.
        let offsetRect = CGRectOffset(self.frame, 400, 400)
        let maxWidth = UInt32(CGRectGetWidth(offsetRect))
        let maxHeight = UInt32(CGRectGetHeight(offsetRect))
        let fillMode = kCAFillModeBoth
        
        let squareColor = UIColor.lightGrayColor()
        
        for i in 1...self.dotCount {
            
            // random initial position
            let randomXFrom: CGFloat = CGFloat(arc4random_uniform(maxWidth) + 1)
            let randomXTo: CGFloat = CGFloat(arc4random_uniform(maxWidth) + 1)
            let randomYFrom: CGFloat = CGFloat(arc4random_uniform(maxHeight) + 1)
            let randomYTo: CGFloat = CGFloat(arc4random_uniform(maxHeight) + 1)
            let randomBeginTime = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) // between 0 and 1
            
            // create new layer
            let layer = CALayer()
            layer.bounds = CGRectMake(0, 0, self.dotSize, self.dotSize)
            layer.position = CGPointMake(randomXFrom, randomYFrom)
            layer.backgroundColor = squareColor.CGColor
            
            // x animation
            let animationX = CABasicAnimation()
            animationX.keyPath = "position.x"
            animationX.fromValue = randomXFrom
            animationX.toValue = randomXTo
            animationX.duration = self.animationDuration
            animationX.fillMode = fillMode
            animationX.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
            
            // y animation
            let animationY = CABasicAnimation()
            animationY.keyPath = "position.y"
            animationY.fromValue = randomYFrom
            animationY.toValue = randomYTo
            animationY.duration = self.animationDuration
            animationY.fillMode = fillMode
            animationY.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
            
            
            // opacity animation
            let animationOpacity = CAKeyframeAnimation()
            animationOpacity.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
            animationOpacity.values = [0.0, 1.0, 0.0, 1.0, 0.0]
            animationOpacity.keyPath = "opacity"
            animationOpacity.duration = self.animationDuration
            animationOpacity.fillMode = fillMode
            animationOpacity.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
            
            // add layer as sublayer
            self.layer.addSublayer(layer)
            
            // add animations
            layer.addAnimation(animationX, forKey: ("movement-animation-x-\(i)"))
            layer.addAnimation(animationY, forKey: ("movement-animation-y-\(i)"))
            layer.addAnimation(animationOpacity, forKey: ("opacity-animation-\(i)"))
            
            // set layer's final position
            layer.position = CGPointMake(randomXTo, randomYTo)
            layer.opacity = 0.0
        }
    }
}