//
//  StringUtils.swift
//  Farmula-iOS
//
//  Created by Luan Silva on 24/01/17.
//  Copyright © 2017 55Apps. All rights reserved.
//

import UIKit
import UIKit

open class StringUtils {
    
    /**
     * The maximum size to which the padding constant(s) can expand.
     */
    static fileprivate let PAD_LIMIT : Int = 8192
    
    //MARK: - Empty
    
    static open func isEmpty(_ str:String?) -> Bool {
        if(str == nil) {
            return false
        }
        guard let str = str , !str.equalsIgnoreCase(string: "nil") else {
            return true
        }
        
        return str.isEmpty
    }
    
    static open func isNotEmpty(_ str:String?) -> Bool {
        return !isEmpty(str)
    }
    
    //MARK: - Split
    static open func split(retorno: String?, withSeparator separator: String) -> [String] {
        guard let retorno = retorno else {
            return []
        }
        
        return retorno.split(separator: separator)
    }
    
    //MARK: - Padding
    static open func leftPad(_ str: String?, toSize size: Int, withCharacter padChar: Character) throws -> String {
        guard let str = str else {
            return ""
        }
        
        let pads = size - str.length
        if (pads < 1) {
            return str
        }
        
        if (pads > PAD_LIMIT) {
            return try leftPad(str, toSize: size, withString: String(padChar))
        }
        
        return padding(pads, withCharacter: padChar) + str
    }
    
    static open func leftPad(_ str: String?, toSize size: Int, withString padStr: String) throws -> String {
        guard let str = str else {
            return ""
        }
        
       
        var padStr = padStr
        
        if (isEmpty(padStr)) {
            padStr = " "
        }
        
        let padLen = padStr.length
        let strLen = str.length
        let pads = size - strLen
        
        if (pads < 1) {
            return str
        }
        
        if (padLen == 1 && pads <= PAD_LIMIT) {
            return try leftPad(str, toSize: size, withCharacter: padStr.charAt(i: 0))
        }
        
        if (pads == padLen) {
            return padStr + str
            
        } else if (pads < padLen) {
            //return padStr.substringFromIndex(startIndex: 0, toIndex: pads) + str
            let index: String.Index = padStr.index(padStr.startIndex, offsetBy: pads)
            return padStr.substring(to: index) + str
        } else {
            var padding : [String] = []
            let padChars = padStr.map { String($0) }
            
            for i in 0 ..< pads {
                padding[i] = padChars[i % padLen]
            }
            
            return padding.joined(separator: "") + str
        }
    }
    
    static open func rightPad(_ str: String?, toSize size: Int, withCharacter padChar: Character) throws -> String {
        guard let str = str else {
            return ""
        }
        
        let pads = size - str.length
        if (pads < 1) {
            return str
        }
        
        if (pads > PAD_LIMIT) {
            return try rightPad(str, toSize: size, withString: String(padChar))
        }
        
        return str + padding(pads, withCharacter: padChar)
    }
    
    static open func rightPad(_ str: String?, toSize size: Int, withString padStr: String) throws -> String {
        guard let str = str else {
            return ""
        }
        
   
        
        var padStr = padStr
        
        if (isEmpty(padStr)) {
            padStr = " "
        }
        
        let padLen = padStr.length
        let strLen = str.length
        let pads = size - strLen
        
        if (pads < 1) {
            return str
        }
        
        if (padLen == 1 && pads <= PAD_LIMIT) {
            return try rightPad(str, toSize: size, withCharacter: padStr.charAt(i: 0))
        }
        
        if (pads == padLen) {
            return str + padStr
            
        } else if (pads < padLen) {
            //return str + padStr.substringFromIndex(startIndex: 0, toIndex: pads)
            let index: String.Index = padStr.index(padStr.startIndex, offsetBy: pads)
            return str + padStr.substring(to: index)
            
            
        } else {
            var padding : [String] = []
            let padChars = padStr.map { String($0) }
            
            for i in 0 ..< pads {
                padding[i] = padChars[i % padLen]
            }
            
            return str + padding.joined(separator: "")
        }
    }
    
    static fileprivate func padding(_ repeatNumber: Int, withCharacter char: Character) -> String {
        var pad = String(char)
        
        while (pad.length < repeatNumber) {
            pad = pad + pad
        }
        
        //return pad.substringToIndex(index: repeatNumber)
        let index: String.Index = pad.index(pad.startIndex, offsetBy: repeatNumber)
        return pad.substring(from: index)
    }
    
    //MARK: - Types
    static fileprivate func getIntegerFromString(_ s: String) -> NSNumber? {
        let formatter = NumberFormatter()
        return formatter.number(from: s)?.intValue as NSNumber?
    }
    
    static open func isInteger(_ s: String?) -> Bool {
        if isEmpty(s) {
            return false
        }
        
        guard let s = s else {
            return false
        }
        
        if let _ = getIntegerFromString(s) {
            return true
        }
        
        return false
    }
    
    static fileprivate func getDoubleFromString(_ s: String) -> NSNumber? {
        let formatter = NumberFormatter()
        return formatter.number(from: s)?.doubleValue as NSNumber?
    }
    
    static open func isDouble(_ s: String?) -> Bool {
        if isEmpty(s) {
            return false
        }
        
        guard let s = s else {
            return false
        }
        
        if let _ = getDoubleFromString(s) {
            return true
        }
        
        return false
    }
    
    //MARK: - Equals
    static open func equals(_ s1: String?, withString s2: String?) -> Bool {
        guard let s1 = s1 , isNotEmpty(s1) else {
            return false
        }
        
        guard let s2 = s2 , isNotEmpty(s2) else {
            return false
        }
        
        return s1 == s2
    }
    
    static open func equalsIgnoreCase(_ s1: String?, withString s2: String?) -> Bool {
        return equals(s1?.uppercased(), withString: s2?.uppercased())
    }
    
    static open func equalsAny(_ s: String?, withArray strings: [String]?) -> Bool {
        guard let s = s , isNotEmpty(s) else {
            return false
        }
        
        guard let strings = strings , strings.count > 0 else {
            return false
        }
        
        for s2 in strings {
            let ok = equals(s, withString: s2)
            if ok {
                return true
            }
        }
        
        return false
    }
    
    static open func equalsIgnoreCaseAny(_ s: String?, withArray strings: [String]?) -> Bool {
        guard let s = s , isNotEmpty(s) else {
            return false
        }
        
        guard let strings = strings , strings.count > 0 else {
            return false
        }
        
        for s2 in strings {
            let ok = equalsIgnoreCase(s, withString: s2)
            if ok {
                return true
            }
        }
        
        return false
    }
    
    static open func notEquals(_ s1: String?, withString s2: String?) -> Bool {
        return !equals(s1, withString: s2)
    }
    
    static open func notEqualsIgnoreCase(_ s1: String?, withString s2: String?) -> Bool {
        return notEquals(s1?.uppercased(), withString: s2?.uppercased())
    }
    
    //MARK: - Types
    static open func isLetters(_ str: String?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        let notLetters = CharacterSet.lowercaseLetters.inverted
        if let _ = str.lowercased().rangeOfCharacter(from: notLetters) {
            return false
        }
        
        return true
    }
    
    static open func isNotLetters(_ str: String?) -> Bool {
        return !isLetters(str)
    }
    
    static open func isDigits(_ str: String?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        let notDigits = CharacterSet.decimalDigits.inverted
        if let _ = str.rangeOfCharacter(from: notDigits) {
            return false
        }
        
        return true
    }
    
    static open func isNotDigits(_ str: String?) -> Bool {
        return !isDigits(str)
    }
    
    static open func isAlphaNumeric(_ str: String?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        let notAlphaNumeric = CharacterSet.alphanumerics.inverted
        if let _ = str.rangeOfCharacter(from: notAlphaNumeric) {
            return false
        }
        
        return true
    }
    
    static open func isNotAlphaNumeric(_ str: String?) -> Bool {
        return !isAlphaNumeric(str)
    }
    
    //MARK: - Cases
    static open func toUpperCase(_ str: String?) -> String {
        return str != nil ? str!.uppercased() : ""
    }
    
    static open func toLowerCase(_ str: String?) -> String {
        return str != nil ? str!.lowercased() : ""
    }
    
    static open func capitalize(_ str: String?) -> String {
        guard let str = str , isNotEmpty(str) else {
            return ""
        }
        return String(str.charAt(i: 0)).uppercased() + str.substringFromIndex(index: 1)
    }
    
    static open func capitalizeAll(_ str: String?) -> String {
        return str != nil ? str!.capitalized : ""
    }
    
    //MARK: - Trim
    static open func trim(_ str: String?) -> String? {
        return str?.trim()
    }
    
    static open func trimAll(_ str: String?) -> String? {
        return str?.removeExcessiveSpaces()
    }
    
    //MARK: - Contains
    static open func indexOfAny(_ str: String?, fromArray searchChars: [Character]?) -> Int {
        guard let str = str , isNotEmpty(str) else {
            return -1
        }
        
        guard let searchChars = searchChars , searchChars.count > 0 else {
            return -1
        }
        
        for i in 0 ..< str.length {
            let ch = str.charAt(i: i)
            
            for j in 0 ..< searchChars.count {
                if (searchChars[j] == ch) {
                    return i
                }
            }
        }
        
        return -1
    }
    
    static open func contains(_ str: String?, fromQuery query: String?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        guard let query = query , isNotEmpty(query) else {
            return false
        }
        
        return str.contains(query)
    }
    
    static open func containsIgnoreCase(_ str: String?, fromQuery query: String?) -> Bool {
        return contains(str?.uppercased(), fromQuery: query?.uppercased())
    }
    
    static open func containsAny(_ str: String?, fromCharacters searchChars: [Character]?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        guard let searchChars = searchChars , searchChars.count > 0 else {
            return false
        }
        
        for i in 0 ..< str.length {
            let ch = str.charAt(i: i)
            
            for j in 0 ..< searchChars.count {
                if (searchChars[j] == ch) {
                    return true
                }
            }
        }
        
        return false
    }
    
    static open func containsAny(_ str: String?, inString searchChars: String?) -> Bool {
        guard let searchChars = searchChars , isNotEmpty(searchChars) else {
            return false
        }
        
        return containsAny(str, fromCharacters: Array(searchChars))
    }
    
    static open func containsAny(_ str: String?, inStrings searchChars: [String]?) -> Bool {
        guard let str = str , isNotEmpty(str) else {
            return false
        }
        
        guard let searchChars = searchChars , searchChars.count > 0 else {
            return false
        }
        
        for searchChar in searchChars {
            let ok = containsAny(str, fromCharacters: Array(searchChar))
            if ok {
                return true
            }
        }
        
        return false
    }
    
    //bold
    static open func setBoldText(textWithBold:String, text:String) -> NSMutableAttributedString{
        let boldText  = textWithBold
        let attrs = [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 15)]
        let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
        
        let normalText = text
        let normalString = NSMutableAttributedString(string:normalText)
        
        attributedString.append(normalString)
        
        return attributedString
    }
    
    
    //MARK: - Replacing
    static open func replaceOnce(_ text: String?, inQuery repl: String?, withReplacement with: String?) -> String {
        return replace(text, inQuery: repl, withReplacement: with, atMaximum: 1)
    }
    
    static open func replace(_ text: String?, inQuery repl: String?, withReplacement with: String?, atMaximum max: Int = -1) -> String {
        guard let text = text else {
            return ""
        }
        
        guard let repl = repl , isNotEmpty(repl) else {
            return text
        }
        
        guard let with = with else {
            return text
        }
        
        var buf = ""
        
        if (max == 0) {
            buf = text
            
        } else if (max == -1) {
            buf = text.replacingOccurrences(of: repl, with: with)
            
        } else {
            var numberOfReplacements = 0
            var index = 0
            
            repeat {
                index = text.indexOfString(subString: repl, atStartIndex: 0)
                
                if (index < text.length) {
                    buf = text.replaceInRange(range: NSMakeRange(index, repl.length), withString: repl)
                    numberOfReplacements += 1
                }
            } while (numberOfReplacements < max || index == text.length)
        }
        
        return buf
    }
    
    //MARK: - Bytes
    static open func getLengthUTF8StringInBytes(_ s: String?) throws -> Int {
        if let s = s {
            if let data = s.data(using: String.Encoding.utf8) {
                return data.count
            }
            
        }
        
        return 0
    }
    
    // MARK: - NSData
    static open func toString(data: Data, encoding: String.Encoding = String.Encoding.utf8) -> String {
        if let json = String(data: data, encoding: encoding) {
            return json
        }
        
        return ""
    }
    
    static open func toData(_ string: String, encoding: String.Encoding = String.Encoding.utf8) -> Data? {
        return string.data(using: encoding)
    }
}
