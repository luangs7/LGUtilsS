//
//  ArrayExtension.swift
//
//  Created by Luan Gabriel
//

import Foundation
import Alamofire

/// Extenstion that allows an array be sent as a request parameters
extension Array {
    /// Convert the receiver array to a `Parameters` object. 
    func asParameters(key:String) -> Parameters {
        return [key: self]
    }
}  
