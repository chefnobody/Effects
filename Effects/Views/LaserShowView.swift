//
//  LaserShowView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/28/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

@IBDesignable
open class LaserShowView: UIView {
    
    @IBInspectable var laserCount: Int = 1000
    @IBInspectable var animationDuration: Double = 10.0
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        // offset main view rect by 200 on all sides so dots will come from off-screen sometimes.
//        let insetRect = self.frame.insetBy(dx: -10, dy: -10)
        //let minX = CGRectGetMinX(insetRect)
        //let maxX = CGRectGetMaxX(insetRect)
//        let maxHeight = insetRect.height
        //let maxWidth = CGRectGetWidth(insetRect)
        //let fillMode = kCAFillModeBoth
        
//        let laserColor = UIColor.lightGray
        
        var points: [CGPoint]
        
        for _ in 1...laserCount {
            let point = frame.randomPointInside()
            points.append(point)
        }
        
        self.layer.addSublayer(<#T##layer: CALayer##CALayer#>)
            
//            //let xFrom = minX
//            //let xTo = maxX
//            let randomY = CGFloat(arc4random_uniform(UInt32(maxHeight) + 1))
//            //let randomDuration = Double(arc4random_uniform(UInt32(self.animationDuration) + 1))
//            let randomBeginTime = Double(arc4random_uniform(UInt32(self.laserCount) + 1))
//            
//            let flip = (randomBeginTime.truncatingRemainder(dividingBy: 2) == 0)
//            
//            // draw straight line across screen starting from random Y position
//            let (layer, _, _) = self.getLineShapeLayer(self.frame, yPosition: randomY, flip: flip)
//            
//            //let animation = self.getLineAnimation()
//            
//            layer.strokeColor = laserColor.cgColor
//            layer.lineWidth = 2.0
            
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
            //self.layer.addSublayer(layer)

            // add animations
//            layer.addAnimation(strokeStartAnimation, forKey: ("stroke-animation-\(i)"))
//
//            // set layer's final position
//            if flipAnimationDirection {
//                layer.strokeStart = 0.0
//            } else {
//                layer.strokeEnd = 0.0
//            }
            
            
        //}
    }
    
    // MARK:- Private methods
    
    // returns a shape layer, its reference start-point and length for use by an animation
    func getLineShapeLayer(_ referenceFrame: CGRect, yPosition: CGFloat, flip: Bool) -> (CAShapeLayer, CGPoint, CGFloat) {
        
        let minX = referenceFrame.minX
        //let maxX = CGRectGetMaxX(referenceFrame)
        let maxWidth = referenceFrame.width
        let randomWidth = CGFloat(arc4random_uniform(UInt32(maxWidth) + 1))
        
        var beginPoint = CGPoint.zero
        var endPoint = CGPoint.zero
        
        if flip {
            beginPoint = CGPoint(x: minX - randomWidth, y: yPosition)
            endPoint = CGPoint(x: minX, y: yPosition)
        } else {
            
        }
        
        let path = UIBezierPath()
        path.move(to: beginPoint)
        path.addLine(to: endPoint)
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
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
