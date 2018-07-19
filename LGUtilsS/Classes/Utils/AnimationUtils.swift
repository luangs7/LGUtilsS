//
//  AnimationUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 26/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

extension Array {
    mutating func shuffle() {
        for i in 0 ..< (count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            swap(&self[i], &self[j])
        }
    }
}

open public class AnimationUtils {
    
    typealias animationCompletion = (Bool) -> Void
    
    static func positionXY(object: NSObject, duration: Double, delay: Double, x: CGFloat, y: CGFloat, completion: animationCompletion? = nil) {
        let objView = object as! UIView
        objView.setNeedsLayout()
        
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
            objView.transform = CGAffineTransform(translationX: x, y: y)
            objView.layoutIfNeeded()
            
        }, completion: completion)
    }
    
    static func changeAlpha(objects: [NSObject]) {
        
        func animate(view: UIView, plus: Double){
            let _delay = plus/2.7 
            
            UIView.animate(withDuration: 1.3, delay: TimeInterval(_delay), usingSpringWithDamping: 5.0, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                view.alpha = 0.85 + CGFloat(_delay)
                view.layoutIfNeeded()
            }, completion: nil)
        }
        
        let objArr = shuffleArray(array: objects.reversed())
        for (index, obj) in objArr.enumerated() {
            let objView = obj as! UIView
            objView.setNeedsLayout()
            animate(view: objView, plus: Double(index+1))
        }
    }
    
    static func animateBlinkAppear(objects: [NSObject], withBounds bounds: CGRect, withDelay delay: Double) {
        
        func animate(view: UIView, plus: Double) {
            let _delay = delay + plus/1.5
            
            UIView.animate(withDuration: 2.5, delay: _delay, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                view.alpha = 1.0
                view.bounds = CGRect(x: bounds.origin.x - 5, y: bounds.origin.y, width: bounds.size.width + 5, height: bounds.size.height + 5)
            }) { (success:Bool) in
                if success {
                    UIView.animate(withDuration: 0.5, animations: {
                        view.bounds = bounds
                    })
                }
            }
        }
        
        for (index, obj) in objects.enumerated() {
            let objView = obj as! UIView
            objView.setNeedsLayout()
            animate(view: objView, plus: Double(index+1))
        }
    }
    
    static func shuffleArray<T>(array: Array<T>) -> Array<T> {
        var arrayy = array
        for index in ((0 + 1)...arrayy.count - 1).reversed(){
            // Random int from 0 to index-1
            let j = Int(arc4random_uniform(UInt32(index-1)))
            // Swap two array elements
            // Notice '&' required as swap uses 'inout' parameters
            swap(&arrayy[index], &arrayy[j])
        }
        return array
    }
    
    static func blinkWhenAppear(_ objct: NSObject) {
        let objView = objct as! UIView
        
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 10.0, initialSpringVelocity: 10.0, options: .curveEaseInOut, animations: {
            objView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (success:Bool) in
            if success {
                resetState(objct: objView, duration: 0.2, delay: 0)
            }
        }
    }
    
    static func resetState(objct: NSObject, duration: Double, delay: Double) {
        
        let objView = objct as! UIView
        objView.setNeedsLayout()
        
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            objView.transform = CGAffineTransform.identity
            objView.layoutIfNeeded()
            
        }, completion: nil)
    }
}
