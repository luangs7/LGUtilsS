//
//  CPFUtils.swift
//  fex-ios
//
//  Updated by Luan Silva on 13/07/17.
//  Thanks to Livetouch-Mini01 on 21/06/2016.
//

import UIKit
import Foundation

open public class CPFUtils: NSObject {
    
    //MARK: - Mask
    
    /**
     Remove máscara de um CPF.
     
     - important: Exemplo de resultado: 12345670089
     
     - Parameters:
     - string: O CPF na qual será removido a máscara.
     
     - Returns: O CPF sem a máscara.
     */
    static public func unmask(string: String?) -> String {
        guard let string = string else {
            return ""
        }
        
        return string.replacingOccurrences(of: ".", with: "").replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "/", with: "").replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "")
    }
    
    
    
    //####NEED UPDATE####
    /**
     Adiciona máscara de um CPF.
     
     - important: Exemplo de resultado: 123.456.700-89
     
     - Parameters:
     - string: O CPF na qual será adicionado a máscara.
     
     - Returns: O CPF com a máscara.
     
    static public func mask(string: String?) -> String {
        guard let string = string, string.isNotEmpty else {
            return ""
        }
        
        let cpf = unmask(string: string)
        if (cpf.length != 11) {
            return ""
        }
        
        let cpfMasked = cpf.substringFromIndex(0, toIndex: 2) + "." + cpf.substringFromIndex(3, toIndex: 5) + "." + cpf.substringFromIndex(6, toIndex: 8) + "-" + cpf.substringFromIndex(9, toIndex: 10)
        
        return cpfMasked
    } */
    
    /**
     Verifica se um CPF está com máscara.
     
     - Parameters:
     - string: O CPF na qual será verificado.
     
     - Returns: Verdadeiro se o CPF está com máscara e Falso caso o contrário.
     */
    
    static public func isMasked(string: String?) -> Bool {
        if let string = string {
            return string.contains(".")
        }
        return false
    }
    
    //MARK: - Validation
    
    /**
     Verifica se um possível CPF é válido.
     
     - Parameters:
     - string: O CPF na qual será validado.
     
     - Returns: Verdadeiro se a string é válida como CPF ou Falso caso o contrário.
     */
    static public func isValid(string: String?) -> Bool {
        guard let string = string, string.isNotEmpty else {
            return false
        }
        
        let cpf = CPFUtils.unmask(string: string)
        if (cpf.length != 11) {
            return false
        }
        
        let cpfArr = Array(cpf)
        var verifier = 0
        for (index, value) in cpfArr.enumerated() {
            if index == 10 {
                if verifier == 10 {
                    return false
                }
                break
            }
            if value == cpfArr[index+1]{
                verifier += 1
            }
        }
        
        var count = 10
        var index = 0
        
        //primeiro digito validador
        var sum1 = 0
        while count >= 2 {
            let value = Int(String(cpfArr[index]))! * count
            sum1 += value
            count -= 1
            index += 1
        }
        
        var firstDigit = (sum1 * 10) % 11
        if firstDigit == 10 {
            firstDigit = 0
        }
        
        //segundo digito
        count = 11
        index = 0
        var sum2 = 0
        
        while count >= 2 {
            let value = Int(String(cpfArr[index]))! * count
            sum2 += value
            count -= 1
            index += 1
        }
        
        var secondDigit = (sum2 * 10) % 11
        if secondDigit == 10 {
            secondDigit = 0
        }
        
        let lastNumber = Int(String(cpfArr[10]))
        let penultNumber = Int(String(cpfArr[9]))
        if firstDigit == penultNumber && secondDigit == lastNumber {
            return true
        }else {
            return false
        }
    }
}




