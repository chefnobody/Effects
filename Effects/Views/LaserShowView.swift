//
//  LaserShowView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/28/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

@IBDesignable
open class LaserShowView: UIView, FancyAnimatable {
    
    @IBInspectable var laserCount: Int = 10
    @IBInspectable var animationDuration: Double = 10.0
    
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
    
    override open func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // MARK:- FancyAnimatable
    
    func runAnimations() {
        var startTimeOffset:Double = 0.25
        
        for laserLayer in laserLayers {
            
            let strokeEndAnimation = createBasicAnimation(keyPath: "strokeEnd",
                                                          fromValue: 0.0,
                                                          toValue: 1.0,
                                                          duration: 0.5,
                                                          fillMode: kCAFillModeBoth,
                                                          beginTime: CACurrentMediaTime(),
                                                          removeOnCompletion: true)
            
            let strokeStartAnimation = createBasicAnimation(keyPath: "strokeStart",
                                                            fromValue: 0.0,
                                                            toValue: 1.0,
                                                            duration: 0.5,
                                                            fillMode: kCAFillModeBoth,
                                                            beginTime: CACurrentMediaTime() + startTimeOffset,
                                                            removeOnCompletion: true)
            
            laserLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")
            laserLayer.add(strokeStartAnimation, forKey: "strokeStartAnimation")
            
            // should set this elsewhere, meh ...
            laserLayer.strokeStart = 1.0
            laserLayer.strokeEnd = 1.0
            
            // Randomly move each layer to some y position.
            //laserLayer.position = CGPoint(x: laserLayer.position.x, y: randomY())
            
            // push time offset a little
            startTimeOffset += 0.2
        }
    }
    
    // MARK:- Helper methods
    
    // Random Y from 0 through the screen height
    func randomY() -> CGFloat {
        return CGFloat(arc4random_uniform(UInt32(frame.height) + 1))
    }
    
    // Returns a tuple for to/from values for offseting a value across the view's frame horizontally
    func horizontalOffsets() -> (to: CGFloat, from: CGFloat) {
        return (-1 * screenOffset, frame.width + screenOffset)
    }
    
    // Creates a CAShapeLayer at a random Y that spans the view horizontally, such that when its stroke is animated it appears to start and end off-screen.
    func createLineLayer() -> CAShapeLayer {
        
        // Randomly align layer somewhere along the vertical.
        let y:CGFloat = randomY()
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
        
        return lineLayer
    }
    
    // Creates a CABasicAnimation instance with the provided inputs
    func createBasicAnimation(keyPath:String, fromValue:Any?, toValue:Any?, duration:CFTimeInterval, fillMode:String, beginTime:CFTimeInterval, removeOnCompletion:Bool) -> CABasicAnimation {
        
        let animation = CABasicAnimation()
        animation.keyPath = keyPath
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = fillMode
        animation.beginTime = beginTime
        animation.isRemovedOnCompletion = removeOnCompletion
        return animation
    }
}
