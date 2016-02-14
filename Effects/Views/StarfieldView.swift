//
//  StarfieldView.swift
//  Effects
//
//  Created by Aaron Connolly on 11/27/15.
//  Copyright © 2015 Top Turn Software. All rights reserved.
//

import UIKit

public enum StarfieldDirection {
    case EastWest
    case WestEast
    case NorthSouth
    case SouthNorth
}

@IBDesignable
public class StarfieldView: UIView {
    
    // MARK:- Public props for consumers
    
    // Speed is the rate at which the starfield moves
    @IBInspectable var speed: Float = 1.0
    
    // Density can be described in terms of the percentage
    // of the view's bounds covered by stars at any given moment
    // "Lorraine ... you are my density."
    @IBInspectable var density: Float = 0.1
    
    @IBInspectable var direction: StarfieldDirection = .EastWest
    @IBInspectable var starColor: UIColor = UIColor.whiteColor()
    @IBInspectable var canvasColor: UIColor = UIColor.blackColor()
    
    // MARK:- Private props used to manage animations variables

    var size: CGFloat = 2.0
    var count: Int32 = 1000
    var insetRect: CGRect = CGRectZero
    var maxAnimationDuration: Float = 30.0
    var animationFillMode: String = kCAFillModeBoth
    
    // MARK:- Lifecycle methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // Can't find a better place for this. Setting it over and over seems redundant
        backgroundColor = canvasColor
        
        // Inset view rect so stars can appear as though they're coming from off-screen
        // this also seems to be the most reliable place for an accurate value for 'bounds'
        // otherwise I'd take it out of -layoutSubviews
        insetRect = CGRectInset(bounds, -20, -20)

        for i in 1...count {
            
            // set random begin time
            let randomDuration = Double(arc4random_uniform(UInt32(maxAnimationDuration) + 1))
            let randomBeginTime = Double(arc4random_uniform(UInt32(count) + 1))
            
            // determine from and to as CGPoints
            let from = convertPoint(fromPoint(), toView: self)
            let to = convertPoint(toPoint(), toView: self)
            
            // ratio of random duration (speed of animation) to the total length of duration
            let beginTimeDurationFactor = randomDuration/Double(maxAnimationDuration)
            
            // 1 is the smallest size, 20 the largest
            let squareSize = 10 - CGFloat(10 * beginTimeDurationFactor) // subtract from 10 to flip it.
            
            let shapeLayer = CALayer()
            shapeLayer.bounds = CGRectMake(0, 0, squareSize, squareSize)
            shapeLayer.position = from
            shapeLayer.backgroundColor = starColor.CGColor
            
            let fromValue = interpolatingValue(from);
            let toValue = interpolatingValue(to)
            let animation = createBasicAnimation(fromValue, toValue: toValue, duration: randomDuration, beginTime: randomBeginTime, speed: speed)
            
            layer.addSublayer(shapeLayer)
            
            shapeLayer.addAnimation(animation, forKey: ("movement-animation-\(i)"))
            
            // set layer's final position
            shapeLayer.position = to
        }
    }
    
    // MARK:- Private methods
    
    func fromPoint() -> CGPoint {
        let randomX = CGFloat(randomIntUpToMax(Int(CGRectGetWidth(insetRect))))
        let randomY = CGFloat(randomIntUpToMax(Int(CGRectGetHeight(insetRect))))
        
        switch direction {
        case .EastWest:
            return CGPointMake(CGRectGetMinX(insetRect), randomY)
        case .NorthSouth:
            return CGPointMake(randomX, CGRectGetMinY(insetRect))
        case .SouthNorth:
            return CGPointMake(randomX, CGRectGetMaxY(insetRect))
        case .WestEast:
            return CGPointMake(CGRectGetMaxX(insetRect), randomY)
        }
    }
    
    func toPoint() -> CGPoint {
        let randomX = CGFloat(randomIntUpToMax(Int(CGRectGetWidth(insetRect))))
        let randomY = CGFloat(randomIntUpToMax(Int(CGRectGetHeight(insetRect))))
        
        switch direction {
        case .EastWest:
            return CGPointMake(CGRectGetMaxX(insetRect), randomY)
        case .NorthSouth:
            return CGPointMake(randomX, CGRectGetMaxY(insetRect))
        case .SouthNorth:
            return CGPointMake(randomX, CGRectGetMinY(insetRect))
        case .WestEast:
            return CGPointMake(CGRectGetMinX(insetRect), randomY)
        }
    }
    
    func interpolatingValue(point: CGPoint) -> CGFloat {
        switch direction {
        case .EastWest, .WestEast:
            return point.x
        case .NorthSouth, .SouthNorth:
            return point.y
        }
    }
    
    func createBasicAnimation(fromValue: CGFloat, toValue: CGFloat, duration: Double, beginTime: Double, speed: Float) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.keyPath = keyPathFromDirection()
        animation.fromValue = fromValue
        animation.toValue = toValue
        animation.duration = duration
        animation.fillMode = animationFillMode
        animation.beginTime = CACurrentMediaTime() + CFTimeInterval(beginTime)
        animation.speed = speed
        return animation
    }
    
    func keyPathFromDirection() -> String {
        switch direction {
        case .EastWest, .WestEast:
            return "position.x"
        case .NorthSouth, .SouthNorth:
            return "position.y"
        }
    }
    
    func randomIntUpToMax(max: Int) -> UInt32 {
        return arc4random_uniform(UInt32(max)) + 1
    }
}