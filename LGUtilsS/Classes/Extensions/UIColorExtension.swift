//
//  UIColorExtension.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 19/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

extension UIColor {
    
    //DevTeam: terminar/arrumar
    class func alertTextColor() -> UIColor {return UIColor.init(hex: "EA6248")}
    class func textColor() -> UIColor {return UIColor.init(hex: "777777")}
    class func placeHolderColor() -> UIColor {return UIColor.init(hex: "D1D1D1")}

    
    /**
     Init recebe HEX string e cria a UIColor.
     
     - param hex:   String
     - param alpha: CGFloat
     
     - return: UIColor
     */
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        
        var hexString = ""
        
        if hex.hasPrefix("#") {
            let nsHex = hex as NSString
            hexString = nsHex.substring(from: 1)
            
        } else {
            hexString = hex
        }
        
        let scanner = Scanner(string: hexString)
        var hexValue: CUnsignedLongLong = 0
        if scanner.scanHexInt64(&hexValue) {
            switch (hexString.count) {
            case 3:
                red = CGFloat((hexValue & 0xF00) >> 8)       / 15.0
                green = CGFloat((hexValue & 0x0F0) >> 4)       / 15.0
                blue = CGFloat(hexValue & 0x00F)              / 15.0
            case 6:
                red = CGFloat((hexValue & 0xFF0000) >> 16)   / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)    / 255.0
                blue = CGFloat(hexValue & 0x0000FF)           / 255.0
            default:
                print("Invalid HEX string, number of characters after '#' should be either 3, 6")
            }
        } else {
            //MQALogger.log("Scan hex error")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    
    class func colorWithRed(red: Int, green: Int, blue: Int, andAlpha alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    class func colorWithRGB(rgbValue: Int, andAlpha alpha: CGFloat) -> UIColor {
         return UIColor(red: CGFloat(rgbValue)/255.0, green: CGFloat(rgbValue)/255.0, blue: CGFloat(rgbValue)/255.0, alpha: alpha)
    }

    
    
    class func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    class func getColorVar(string: String) -> UIColor {
        if (string.count > 0){
            if (string.first == "-") {
                return UIColor(red: 0.980, green: 0.180, blue: 0.180, alpha: 1.0)
            } else {
                return UIColor(red: 0.564, green: 0.866, blue: 0.243, alpha: 1.0)
            }
        }
        return .gray
    }
}

