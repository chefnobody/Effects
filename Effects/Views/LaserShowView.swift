//
//  LaserShowView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/28/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

@IBDesignable
public class LaserShowView: UIView {
    
    @IBInspectable var laserCount: Int = 1000
    @IBInspectable var animationDuration: Double = 10.0
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // offset main view rect by 200 on all sides so dots will come from off-screen sometimes.
        let insetRect = CGRectInset(self.frame, -10, -10)
        //let minX = CGRectGetMinX(insetRect)
        //let maxX = CGRectGetMaxX(insetRect)
        let maxHeight = CGRectGetHeight(insetRect)
        //let maxWidth = CGRectGetWidth(insetRect)
        //let fillMode = kCAFillModeBoth
        
        let laserColor = UIColor.lightGrayColor()
        
        for _ in 1...self.laserCount {
            
            //let xFrom = minX
            //let xTo = maxX
            let randomY = CGFloat(arc4random_uniform(UInt32(maxHeight) + 1))
            //let randomDuration = Double(arc4random_uniform(UInt32(self.animationDuration) + 1))
            let randomBeginTime = Double(arc4random_uniform(UInt32(self.laserCount) + 1))
            
            let flip = (randomBeginTime % 2 == 0)
            
            // draw straight line across screen starting from random Y position
            let (layer, _, _) = self.getLineShapeLayer(self.frame, yPosition: randomY, flip: flip)
            
            //let animation = self.getLineAnimation()
            
            layer.strokeColor = laserColor.CGColor
            layer.lineWidth = 2.0
            
            // stroke begin animation ? 

            
            // position it off-screen?
            
//            // random initial position
//            let randomXFrom: CGFloat = CGFloat(arc4random_uniform(maxWidth) + 1)
//            let randomXTo: CGFloat = CGFloat(arc4random_uniform(maxWidth) + 1)
//
//            let randomYTo: CGFloat = CGFloat(arc4random_uniform(maxHeight) + 1)
//            let randomBeginTime = CGFloat(Float(arc4random()) / Float(UINT32_MAX)) // between 0 and 1
//            
//            // create new layer
//            let layer = CALayer()
//            layer.bounds = CGRectMake(0, 0, self.dotSize, self.dotSize)
//            layer.position = CGPointMake(randomXFrom, randomYFrom)
//            layer.backgroundColor = squareColor.CGColor
//            
//            // x animation
//            let animationX = CABasicAnimation()
//            animationX.keyPath = "position.x"
//            animationX.fromValue = randomXFrom
//            animationX.toValue = randomXTo
//            animationX.duration = self.animationDuration
//            animationX.fillMode = fillMode
//            animationX.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
//            
//            // y animation
//            let animationY = CABasicAnimation()
//            animationY.keyPath = "position.y"
//            animationY.fromValue = randomYFrom
//            animationY.toValue = randomYTo
//            animationY.duration = self.animationDuration
//            animationY.fillMode = fillMode
//            animationY.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
//            
//            
//            // opacity animation
//            let animationOpacity = CAKeyframeAnimation()
//            animationOpacity.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
//            animationOpacity.values = [0.0, 1.0, 0.0, 1.0, 0.0]
//            animationOpacity.keyPath = "opacity"
//            animationOpacity.duration = self.animationDuration
//            animationOpacity.fillMode = fillMode
//            animationOpacity.beginTime = CACurrentMediaTime() + CFTimeInterval(randomBeginTime)
//            

            // add layer as sublayer
            self.layer.addSublayer(layer)

            // add animations
//            layer.addAnimation(strokeStartAnimation, forKey: ("stroke-animation-\(i)"))
//
//            // set layer's final position
//            if flipAnimationDirection {
//                layer.strokeStart = 0.0
//            } else {
//                layer.strokeEnd = 0.0
//            }
            
            
        }
    }
    
    // MARK:- Private methods
    
    // returns a shape layer, its reference start-point and length for use by an animation
    func getLineShapeLayer(referenceFrame: CGRect, yPosition: CGFloat, flip: Bool) -> (CAShapeLayer, CGPoint, CGFloat) {
        
        let minX = CGRectGetMinX(referenceFrame)
        //let maxX = CGRectGetMaxX(referenceFrame)
        let maxWidth = CGRectGetWidth(referenceFrame)
        let randomWidth = CGFloat(arc4random_uniform(UInt32(maxWidth) + 1))
        
        var beginPoint = CGPointZero
        var endPoint = CGPointZero
        
        if flip {
            beginPoint = CGPointMake(minX - randomWidth, yPosition)
            endPoint = CGPointMake(minX, yPosition)
        } else {
            
        }
        
        let path = UIBezierPath()
        path.moveToPoint(beginPoint)
        path.addLineToPoint(endPoint)
        
        let layer = CAShapeLayer()
        layer.path = path.CGPath
        
        return (layer, beginPoint, randomWidth)
    }
//    
//    func getLineAnimation(startingPoint: CGPoint, lineLength: CGFloat) -> CALayerAnimation {
//        
//        
//        
//        let strokeStartAnimation = CABasicAnimation()
//        strokeStartAnimation.keyPath = "position.x" // flipAnimationDirection ? "strokeStart" : "strokeEnd"
//        strokeStartAnimation.fromValue = 1.0
//        strokeStartAnimation.toValue = 0.0
//        strokeStartAnimation.fillMode = fillMode
//        strokeStartAnimation.duration = randomDuration
//    }
    
}
