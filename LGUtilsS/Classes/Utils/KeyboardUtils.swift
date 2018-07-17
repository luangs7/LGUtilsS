//
//  KeyboardUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 24/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit


open class KeyboardUtils {
    
    //MARK: - Show
    
    static open func show(_ view: UIKeyInput?) {
        guard let view = view as? UIView else {
            return
        }
        
        let selector = #selector(view.becomeFirstResponder)
        
        if (view.responds(to: selector)) {
            view.perform(selector)
        }
    }
    
    static open func hide(_ view: UIView?) {
        guard let view = view else {
            return
        }
        
        view.endEditing(true)
    }
    
    //MARK: - Sizes
    
    static open func getKeyboardSizeFromNotification(_ notification: Notification) -> CGSize {
        guard let userInfo = (notification as NSNotification).userInfo else {
            return CGSize(width: 0.0, height: 0.0)
        }
        
        //guard let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size else {
        //return CGSize(width: 0.0, height: 0.0)
        //}
        let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size
        return keyboardSize
    }
    
    static open func getKeyboardWidthFromNotification(_ notification: Notification) -> CGFloat {
        let size = getKeyboardSizeFromNotification(notification)
        return size.width
    }
    
    static open func getKeyboardHeightFromNotification(_ notification: Notification) -> CGFloat {
        let size = getKeyboardSizeFromNotification(notification)
        return size.height
    }
    
}
