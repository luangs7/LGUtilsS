//
//  UINavigationBarExtension.swift
//  brasilsaude
//
//  Created by Squarebits on 08/05/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func setGradientBackgroundNav(colors: [UIColor]) {
        
        var updatedFrame = bounds
        updatedFrame.size.height += self.frame.origin.y
        let gradientLayer = CAGradientLayer(frame: updatedFrame, colors: colors)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: UIBarMetrics.default)
    }
}
