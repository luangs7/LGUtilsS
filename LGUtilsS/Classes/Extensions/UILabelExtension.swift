//
//  UILabelExtension.swift
//  brasilsaude
//
//  Created by Squarebits on 10/05/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UILabel{
    internal func boldText(normalText:String,boldText:String){
  
        
        let attributedString = NSMutableAttributedString(string:normalText)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)]
        let boldString = NSMutableAttributedString(string: boldText, attributes:attrs)
        
        attributedString.append(boldString)
        attributedText = attributedString
    }
}
