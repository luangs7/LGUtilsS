//
//  UIViewControllerExtension.swift
//  LausGirl
//
//  Created by Squarebits on 26/04/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UIViewController{

    public func ignoreEvents(){
         view.endEditing(true)
         UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    public func endIgnoreEvents(){
        if UIApplication.shared.isIgnoringInteractionEvents {
            UIApplication.shared.endIgnoringInteractionEvents()
        }
    }
    
    public func setBlackView()->UIView{
        
        let blackView = UIView()
        
        //here get all application view
        
        if let window = UIApplication.shared.keyWindow{

//            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(blackView.removeBlackView))
//            blackView.addGestureRecognizer(tap)

            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: {
                blackView.alpha = 1
            })
            
        }
        
        return blackView
    }
    
    func handleDismiss(){
        
    }
}
