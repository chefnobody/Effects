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
    
    @IBInspectable var laserCount: Int = 50
    @IBInspectable var animationDuration: Double = 1.0
    @IBInspectable var laserLengthLagTime: Double = 0.5
    
    let screenOffset:CGFloat = 100.0
    
    var laserLayers:[CAShapeLayer] = []
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        
        backgroundColor = UIColor.black
        
        for _ in 1...laserCount {
            let lineLayer = createLineLayer()
            
            // store reference to laser layers
            laserLayers.append(lineLayer)
            
            // add as sublayer
            layer.addSublayer(lineLayer)
        }
    }
    
    // MARK:- Helper methods
    
    // Random Y somewhere inside the bounds
    func randomY() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(bounds.height) + 1))
    }
    
    // Returns a tuple for to/from values for offseting a value across the view's frame horizontally
    func horizontalOffsets() -> (to: CGFloat, from: CGFloat) {
        return (-1 * screenOffset, bounds.width + screenOffset)
    }
    
    // Creates a CAShapeLayer at a random Y that spans the view horizontally, such that when its stroke is animated it appears to start and end off-screen.
    func createLineLayer() -> CAShapeLayer {
        
        // Start layer at the 0 for Y position.
        let y:CGFloat = 0
        let (horizontalTo, horizontalFrom) = horizontalOffsets()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: horizontalTo, y: y))
        path.addLine(to: CGPoint(x: horizontalFrom, y: y))
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = path.cgPath
        lineLayer.strokeColor = UIColor.white.cgColor
        lineLayer.lineWidth = 2.0
        
        // Set initial stroke values for animation.
        // Will animate these properties from 0.0 -> 1.0
        lineLayer.strokeStart = 0.0
        lineLayer.strokeEnd = 0.0
        
        // Randomly position line layer
        moveLineLayer(shapeLayer: lineLayer)
        
        return lineLayer
    }
    
    // Creates a CABasicAnimation instance with the provided inputs
    func animate(forLayer layer: CAShapeLayer, keyPath:String, fromValue:Any?, toValue:Any?, duration:CFTimeInterval, fillMode:String, beginTime:CFTimeInterval, withAdditiveAnimation:Bool) {
        
        // Disable the implicit animation and set the keyPath toValue for the model:
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        layer.setValue(toValue, forKey: keyPath)
        CATransaction.commit()
        
        let animation = CABasicAnimation()
        animation.keyPath = keyPath
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = fillMode
        animation.beginTime = beginTime
        animation.delegate = self
        
        layer.add(animation, forKey: "\(keyPath)-Animation")
        
        // Cool: Add an additive stroke/line width animation
        if (withAdditiveAnimation) {
            // Disable the implicit animation
            CATransaction.begin()
            CATransaction.setDisableActions(true)
            layer.lineWidth = 6.0
            CATransaction.commit()
            
            let deviate = CABasicAnimation(keyPath: "lineWidth")
            deviate.isAdditive = true
            deviate.toValue = 6.0
            deviate.fromValue = 2.0
            deviate.autoreverses = true
            deviate.duration = 0.1
            deviate.timingFunction = CAMediaTimingFunction(name: "easeInEaseOut")
            deviate.beginTime = beginTime
            layer.add(deviate, forKey: "lineWidth-Additive-Animation")
        }
    }
}

extension LaserShowView: FancyAnimatable {
    // MARK:- FancyAnimatable
    
    func runAnimations() {
        var startTimeOffset:Double = 0.0
        
        for lineLayer in laserLayers {
            
            animate(forLayer: lineLayer,
                    keyPath: "strokeEnd",
                    fromValue: 0.0,
                    toValue: 1.0,
                    duration: animationDuration,
                    fillMode: kCAFillModeBoth,
                    beginTime: CACurrentMediaTime() + startTimeOffset,
                    withAdditiveAnimation: false)
            
            animate(forLayer: lineLayer,
                    keyPath: "strokeStart",
                    fromValue: 0.0,
                    toValue: 1.0,
                    duration: animationDuration,
                    fillMode: kCAFillModeBoth,
                    beginTime: CACurrentMediaTime() + startTimeOffset + laserLengthLagTime,
                    withAdditiveAnimation: false)
            
            // push time offset a little
            startTimeOffset += 0.2
        
            moveLineLayer(shapeLayer: lineLayer)
        }
    }
    
    func moveLineLayer(shapeLayer: CAShapeLayer) {
        // Reposition the line layer and don't forget to disable the implicit animation.
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        shapeLayer.position.y = randomY()
        CATransaction.commit()
    }
}

extension LaserShowView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("\(anim) finished: \(flag)")
    }
}
