//
//  UIApplicationExtensio.swift
//
//  Created by Livetouch
//  Updated by Luan Silva
//

import UIKit

public extension UIApplication {
    
    public static func topViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        
        /*
         XXX:
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let currentViewController = appDelegate.window?.rootViewController?.presentedViewController
         
        */
        
        return base
    }
    
    func statusBarView() -> UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
