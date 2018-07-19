//
//  JuquinhaTF.swift
//  ClickServicesApp
//
//  Created by Luan Silva on 30/11/17.
//  Copyright © 2017 squarebits. All rights reserved.
//

import UIKit

@IBDesignable
open class JuquinhaTF: UITextField {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    override func draw(_ rect: CGRect) {
        layer.backgroundColor = UIColor.blue.cgColor
    }

}
