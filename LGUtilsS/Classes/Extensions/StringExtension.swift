//
//  StringExtension.swift
//
//  Created by Livetouch
//  Updated by Luan Silva
//

import UIKit


public extension String {
    
    
    
    public var UTF8String: UnsafePointer<Int8>? {
        if self.isEmpty {
            return nil
        }
        return (self as NSString).utf8String
    }
    
    public var isNotEmpty : Bool {
        return !self.isEmpty
    }
    
    
    /**
     Remove máscara da string.
     */
    func unmask() -> String {
        return self.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: ",", with: "")
    }
    
    //MARK: - Path Component
    
    public func stringByAppendingPathComponent(path: String) -> String {
        return (self as NSString).appendingPathComponent(path)
    }
    
    //MARK: - Equals
    
    public func equalsIgnoreCase(string: String) -> Bool {
        return self.uppercased() == string.uppercased()
    }
    
    //MARK: - Variables
    
    public var length : Int {
        return self.count
    }
    
    public var integerValue : Int {
        if self.isEmpty {
            return 0
        }
        return (self as NSString).integerValue
    }
    
    public var floatValue : Float {
        if self.isEmpty {
            return 0.0
        }
        return (self as NSString).floatValue
    }
    
    public var doubleValue : Double {
        if self.isEmpty {
            return 0.0
        }
        return (self as NSString).doubleValue
    }
    
    public func containsStringIgnoreCase(find: String) -> Bool {
        //return self.uppercaseString.containsString(find.uppercaseString)
        return self.uppercased().contains(find.uppercased())
    }
    
    //MARK: - Split
    public func split(separator: String) -> [String] {
        //return self.componentsSeparatedByString(separator)
        return self.components(separatedBy: separator)
    }
    
    //MARK: - Insert
    public func insertString(string: String, atIndex index: Int) -> String {
        let prefix = self.prefix(index)
        let suffix = self.suffix(self.count - index)
        return  String(prefix) + string + String(suffix)
    }
    
    //MARK: - ChatAt
    
    public func charAt(i: Int) -> Character {
        return self[self.index(startIndex, offsetBy: i)]
    }
    
    //MARK: - replace
    
    public func indexOfString(subString: String, atStartIndex start: Int) -> Int {
        var start = start
        
        if (start < 0) {
            start = 0
        }
        
        let subCount = subString.length
        let count = self.length
        
        if (subCount > 0) {
            if (subCount + start > count) {
                return -1;
            }
            
            let firstChar = subString.charAt(i: 0)
            
            while true {
                let i = indexOfChar(searchChar: firstChar, atStartIndex: start)
                
                if (i == -1 || subCount + i > count) {
                    return -1
                }
                
                var o1 = i + 1
                var o2 = 1
                
                while (o2 < subCount && charAt(i: o1) == subString.charAt(i: o2)) {
                    // Intentionally empty
                    
                    o1 += 1
                    o2 += 1
                }
                
                if (o2 == subCount) {
                    return i
                }
                
                start = i + 1
            }
        }
        
        return start < count ? start : count;
    }
    
    public func indexOfChar(searchChar: Character, atStartIndex start: Int) -> Int {
        if (start > self.length) {
            return -1
        }
        
        //        let substring = self.substringWithRange(self.characters.startIndex.advancedBy(start)...self.characters.endIndex.advancedBy(-1))
        
        
        let lo = self.index(self.startIndex, offsetBy: start)
        let hi = self.index(self.endIndex, offsetBy: -1)
        
        let substring = lo ..< hi
        
        let characters = Array(self[substring])
        
        for (index, character) in characters.enumerated() {
            if (character == searchChar) {
                return index
            }
        }
        
        return -1
    }
    
    
    //MARK: - Characters
    public subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range<Int>) -> String {
        //        let start = startIndex.advancedBy(r.startIndex)
        let start = self.index(self.startIndex, offsetBy: r.lowerBound)
        
        //        let end = start.advancedBy(r.endIndex - r.startIndex)
        let end = self.index(self.startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
    
    //MARK: - Contains
    
    public func containsInArray(array: [String]) -> Bool {
        for element in array {
            if (self.containsStringIgnoreCase(find: element)) {
                return true
            }
        }
        return false
    }
    
    func beginsWith(string: String) -> Bool {
        //        guard let range = rangeOfString(subString: satStartIndextring, options:[.AnchoredSearch, .CaseInsensitiveSearch]) else {
        //            return false
        //        }
        
        guard let range = range(of: string, options: [.anchored, .caseInsensitive], range: nil, locale: nil) else{
            return false
        }
        
        //        return range.startIndex == startIndex
        return range.lowerBound == startIndex
    }
    
    //MARK: - Replace
    
    public func replace(_ of: String, with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    public func replaceFirstOccurrence(target: String, withString newString: String) -> String {
        if let range = self.range(of: target) {
            //            return self.stringByReplacingCharactersInRange(range, withString: newString)
            return self.replacingCharacters(in: range, with: newString)
        }
        return self
    }
    
    public func replaceInRange(range: NSRange, withString newString: String) -> String {
        return (self as NSString).replacingCharacters(in: range, with: newString)
    }
    
    //MARK: - Substring
    
    public func substringFromIndex(index:Int) -> String {
        //        return self.substringFromIndex(index: self.startIndex.advancedBy(index))
        return self.substringFromIndex(index: index)
    }
    
    public func substringToIndex(index: Int) -> String {
        //        return self.substringToIndex(index: self.startIndex.advancedBy(index))
        return self.substringToIndex(index: index)
    }
    
    public func substringFromIndex(startIndex: Int, toIndex endIndex: Int) -> String {
        let length = self.length
        if (endIndex >= length || (endIndex - startIndex) >= length || startIndex >= endIndex) {
            return ""
        }
        //        return self.substringWith(self.startIndex.advancedBy(startIndex)...self.startIndex.advancedBy(endIndex))
        
        return ""
    }
    
    //MARK: - Trim
    
    public func trim() -> String {
        //        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return self.trimmingCharacters(in: CharacterSet.whitespaces)
    }
    
    public func removeExcessiveSpaces() -> String {
        //        let components = self.componentsSeparatedByCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let components = self.components(separatedBy: CharacterSet.whitespaces)
        let filtered = components.filter({!$0.isEmpty})
        return filtered.joined(separator: " ")
    }
    
    //MARK: - Number
    
    public func isNumber() -> Bool {
        if (self != "") {
            let notDigits = NSCharacterSet.decimalDigits.inverted
            if (self.rangeOfCharacter(from: notDigits) == nil) {
                return true
            }
        }
        return false
    }
    
    //MARK: - Size
    
    public func sizeWithAttributes(attrs: [String: AnyObject]) -> CGSize {
        return (self as NSString).size(attributes: attrs)
    }
    
    //MARK: - Encoding
    
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        //        return stringByAddingPercentEncodingWithAllowedCharacters(allowed)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
    
    //MARK: - Conversoes
    
    public func toDictionary() throws -> [String : AnyObject] {
        guard let data = self.toNSData() else {
            throw NSError(domain: "StringDomain", code: 1, userInfo: [NSLocalizedDescriptionKey : "Erro ao transformar string em dicionario"])
        }
        
        guard let jsonObject = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as? [String : AnyObject] else {
            
            throw NSError(domain: "StringDomain", code: 1, userInfo: [NSLocalizedDescriptionKey : "Erro ao transformar string em dicionario"])
        }
        
        return jsonObject
    }
    
    public func toNSData() -> NSData? {
        let data = self.data(using: String.Encoding.utf8)
        return data as NSData?
    }
    
    var html2AttStr: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType, NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
    
    public func convertDataFrom(typeOf:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = typeOf
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date!)
    }
    
}
