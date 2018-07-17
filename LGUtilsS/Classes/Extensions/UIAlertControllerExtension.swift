//
//  UIAlertControllerExtension.swift
//
//  Created by Livetouch
//  Updated by Luan Silva
//

import UIKit


import Foundation

public extension UIAlertController {
    
    public func show(animated: Bool = true) {
        
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
        
        guard let top = UIApplication.topViewController() else {
            return
        }
        
        if self.presentedViewController == nil {
            top.present(self, animated: animated, completion: nil)
        }
    }
}
