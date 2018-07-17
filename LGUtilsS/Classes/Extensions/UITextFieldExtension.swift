//
//  UITextFieldExtension.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 20/03/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit

public extension UITextField {
    
    internal enum TextFieldType {
        case email, password, phone, text
    }
    
    
    /**
     Define qual o tipo do UITextField.
     - returns: TextFieldType
     */
    internal func getType() -> TextFieldType {
        if let i = self.accessibilityIdentifier {
            switch i {
            case "password":
                return .password
            case "phone":
                return .phone
            case "email":
                return .email
            default:
                return .text
            }
        }
        return .text
    }
    
    /*
    internal func validate(withType type: TextFieldType, isRequired required : Bool, userFeedback show : Bool, withImage image : UIImageView?) -> Bool {
        let string = self.text!
        if string == "" && required {
            if show {
                self.changeTextFieldStatus(toValid: false, withLabel: "*campo obrigatório")
                image?.validate(isValid: false)
            }
            return false
        }
        
        switch type {
        case .email:
            if (!EmailUtils.isValid(string)) {
                if show {
                    changeTextFieldStatus(toValid: false, withLabel: "Email inválido")
                    image?.validate(isValid: false)
                }
                return false
            }
        case .password:
            if (string.length < 8) {
                if show {
                    changeTextFieldStatus(toValid: false, withLabel: "Senha é muito curta")
                    image?.validate(isValid: false)
                }
                return false
            }
        default:
            break
        }
        changeTextFieldStatus(toValid: true, withLabel: nil)
        image?.validate(isValid: true)
        return true
    } */
    
    
    internal func changeTextFieldStatus(toValid: Bool, withLabel : String?) {
        if toValid {
            setTextWith(color: UIColor.textColor())
            setPlaceholderWith(color: UIColor.placeHolderColor())
            removeLabelAlert()
        } else {
            setTextWith(color: UIColor.alertTextColor())
            setPlaceholderWith(color: UIColor.alertTextColor())
            if let label = withLabel {
                setLabelAlert(text: label)
            }
        }
    }
    
    private func setPlaceholderWith(color: UIColor){
        if let placeholder = self.placeholder {
            let string = placeholder.replacingOccurrences(of: "*", with: "")
            if color == UIColor.alertTextColor() {
                attributedPlaceholder = NSAttributedString(string: string+"*",                                                              attributes: [NSForegroundColorAttributeName: color])
            }
        }
    }
    
    private func setTextWith(color: UIColor){
        textColor = color
    }
    
    private func setLabelAlert(text : String){
        clipsToBounds = false
        for view in subviews {
            let label = view as? UILabel
            if view == label {
                view.removeFromSuperview()
            }
        }
        
        let alertLabel = UILabel(frame: CGRect(x: center.x - 25, y: 13, width: 200, height: 25))
        alertLabel.text = text
        alertLabel.textColor = UIColor.alertTextColor()
        let font = UIFont(name: self.font!.fontName, size: 11)
        alertLabel.font = font
        addSubview(alertLabel)
    }
    
    private func removeLabelAlert() {
        for view in subviews {
            let label = view as? UILabel
            if view == label {
                view.removeFromSuperview()
            }
        }
    }
    
    
    
    internal func onApplyMask(range: NSRange,string: String)->Bool{
        if let identifier = accessibilityIdentifier {
    //        let defaultColor = UIColor.colorWithRGB(rgbValue: 207, andAlpha: 1)
            
            if string == "" && identifier != "work_price" && identifier != "identifier" {
                return true
            }
        
            switch identifier {
    //        case "name":
    //            nameLine.backgroundColor = defaultColor
    //        case "email":
    //            emailLine.backgroundColor = defaultColor
    //            //        case "password":
    //        //            passwordLine.backgroundColor = defaultColor
            case "zipcode":
    //            zipcodeLine.backgroundColor = defaultColor
                if text!.length >= 9 {
                    return false
                }
                if text!.length == 5 {
                    text = text! + "-"
                }
            case "identifier":
    //            identifierLine.backgroundColor = defaultColor
                
                if string == "" {
                    if text!.length == 14 {
                        text = text!.replace("/", with: "")
                        text = text!.replace("-", with: "")
                        text = text!.replace(".", with: "")
                        
                        var tfString = text!
                        tfString.insert(".", at: tfString.index(tfString.startIndex, offsetBy: 3))
                        tfString.insert(".", at: tfString.index(tfString.startIndex, offsetBy: 7))
                        tfString.insert("-", at: tfString.index(tfString.startIndex, offsetBy: 11))
                        
                        text = tfString
                    }
                    
                    return true
                }
                
                if text!.length == 3 || text!.length == 7 && text != "" {
                    text = text! + "."
                }
                if text!.length == 11 && !text!.contains("-") && text != "" {
                    text = text! + "-"
                }
                
                if text!.length >= 14 {
                    if text!.length >= 18 && string != "" {
                        return false
                    }
                    
                    if  text!.contains(".") && !text!.contains("/") {
                         text =  text!.replace(".", with: "")
                         text =  text!.replace("-", with: "")
                        
                        var tfString =  text!
                        tfString.insert(".", at: tfString.index(tfString.startIndex, offsetBy: 2))
                        tfString.insert(".", at: tfString.index(tfString.startIndex, offsetBy: 6))
                        tfString.insert("/", at: tfString.index(tfString.startIndex, offsetBy: 10))
                         text = tfString
                        return true
                    }
                    
                    if  text!.length == 14 && !text!.contains("-"){
                        var tfString =  text!
                        tfString.insert("-", at: tfString.index(tfString.startIndex, offsetBy: 13))
                         text = tfString
                    }
                    
                    if  text!.length == 16 && !text!.contains("-"){
                        var tfString =  text!
                        tfString.insert("-", at: tfString.index(tfString.startIndex, offsetBy: 15))
                         text = tfString
                    }
                }
                
            case "phone":
    //            phoneLine.backgroundColor = defaultColor
                let totalChar =  text!.length
                var tfString =  text!
                
                if totalChar >= 14 {
                    return false
                }
                if totalChar == 2 {
                    tfString.insert("(", at: tfString.index(tfString.startIndex, offsetBy: 0))
                    tfString.insert(")", at: tfString.index(tfString.startIndex, offsetBy: 3))
                    tfString.insert(" ", at: tfString.index(tfString.startIndex, offsetBy: 4))
                }
                
                if totalChar == 9 {
                    tfString.insert("-", at: tfString.index(tfString.startIndex, offsetBy: 9))
                }
                
                 text = tfString
            case "cellphone":
    //            cellLine.backgroundColor = defaultColor
                let totalChar =  text!.length
                var tfString =  text!
                
                if totalChar >= 15 {
                    return false
                }
                if totalChar == 2 {
                    tfString.insert("(", at: tfString.index(tfString.startIndex, offsetBy: 0))
                    tfString.insert(")", at: tfString.index(tfString.startIndex, offsetBy: 3))
                    tfString.insert(" ", at: tfString.index(tfString.startIndex, offsetBy: 4))
                    
                }
                //            if totalChar == 6 {
                //                tfString.insert(" ", at: tfString.index(tfString.startIndex, offsetBy: 6))
                //            }
                if totalChar == 11 {
                    tfString.insert("-", at: tfString.index(tfString.startIndex, offsetBy: 10))
                }
                
                 text = tfString
            case "work_price":
                //            workValueLine.backgroundColor = defaultColor
                
                if  text!.length >= 10 && string != "" {
                    return false
                }
                
                if string == "" {
                    var characters = Array( text!)
                    characters.removeLast()
                     text = String(characters)
                     text =  text?.replace(",", with: "")
                    if  text!.length >= 2 {
                         text =  text!.insertString(string: ",", atIndex:  text!.length - 1)
                    }
                    
                    if  text!.length <= 6 &&  text!.contains(".") {
                         text =  text!.replace(".", with: "")
                    }
                    return false
                }
                
                if  text!.contains(",") {
                     text =  text?.replace(",", with: "")
                }
                
                if  text!.length >= 2 {
                     text =  text!.insertString(string: ",", atIndex:  text!.length - 1)
                }
                
                if  text!.contains(".") {
                     text =  text?.replace(".", with: "")
                }
                
                if  text!.length >= 6 {
                     text =  text!.insertString(string: ".", atIndex:  text!.length - 5)
                }
                
            case "discount":
                //            discountLine.backgroundColor = defaultColor
                if  text!.length == 4 {
                    return false
                }
                
                let stringInput =  text!.replace("%", with: "") + string
                if let inputValue = Int(stringInput) {
                    if inputValue >= 100 {
                         text = "99%"
                        return false
                    }
                }
                
                if  text!.contains("%")  {
                     text =  text!.replace("%", with: "")
                }
                if  text!.length >= 1 {
                     text =  text! + string + "%"
                    return false
                }
            case "zipcode":
                //            zipcodeLine.backgroundColor = .white
                
                //mask
                if  text!.length >= 9 {
                    return false
                }
                if  text!.length == 5 {
                     text =  text! + "-"
                }
            case "birthday":
                let separator = "/"
                if  text!.length == 2 || text!.length == 5{
                    text =  text! + separator
                }
                if text!.length == 10{
                    return false
                }
            case "card_number":
                
                //mask
                if text!.length >= 23{
                    return false
                }
                if text!.length == 4 || text!.length == 9 || text!.length == 14 || text!.length == 19  {
                    text = text! + " "
                }
                
            case "card_valid_through":
                //mask
                if text!.length >= 7 {
                    return false
                }
                if text!.length == 2 {
                    text! = text! + "/"
                }
            case "card_cvv":
                if text!.length >= 3 {
                    return false
                }
            default:
                break
            }
            
            return true
        }else{
            return true
        }
    }
}
