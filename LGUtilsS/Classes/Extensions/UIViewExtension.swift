//
//  UIViewExtension.swift
//  brasilsaude
//
//  Created by Squarebits on 08/05/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UIView{
    
    func setGradientBackground(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    func removeBlackView(){
        UIView.animate(withDuration: 0.5, delay: 0.0, options: [], animations: {
            self.alpha = 0
        }, completion: { (finished: Bool) in
            self.removeFromSuperview()
        })
    }
}
