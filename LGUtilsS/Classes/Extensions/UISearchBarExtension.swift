//
//  UISearchBarExtension.swift
//
//  Created by Luan Silva on 06/07/17.
//  Copyright © 2017. All rights reserved.
//
// Thanks to Jan
// https://stackoverflow.com/questions/29375696/how-to-change-uisearchbar-placeholder-and-image-tint-color

import UIKit

extension UISearchBar {

    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        return getViewElement(type: UITextField.self)
    }
    
    func setSearchImageColor(color: UIColor) {
        if let textField = getSearchBarTextField() {
            let imageView = textField.leftView as! UIImageView
            imageView.tintImageViewWith(color: color)
            
            
            let button = textField.value(forKey: "clearButton") as! UIButton
            if let image = button.imageView?.image {
                button.setImage(image.maskWith(color: .white), for: .normal)
                
            }
        }
    }
}
