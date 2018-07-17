//
//  EmailUtils.swift
//  Pods
//
//  Created by Livetouch-Mini01 on 21/06/2016.
//
//

import UIKit

import MobileCoreServices
import MessageUI

public protocol EmailUtilsDelegate: class {
    func onEmailSuccessful()
    func onEmailCancelled()
    func onEmailFailed()
}

open class EmailUtils: NSObject, MFMailComposeViewControllerDelegate {
    
    //MARK: - Variables
    static var openEmail: EmailUtils?
    weak var delegate : EmailUtilsDelegate?
    
    //MARK: - Valid
    static open func isValid(_ string: String?, withStrictRules strict: Bool = false) -> Bool {
        let emailRegex = "^.+@.+\\.[A-Za-z]{2}[A-Za-z]*$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailTest.evaluate(with: string)
    }
    
    //MARK: - Send
    static open func canSendEmail() -> Bool {
        return MFMailComposeViewController.canSendMail()
    }
    
    static open func sendEmailTo(_ destinationEmail: String, withSubject subject: String = "", andBody body: String = "") {
        
        if !canSendEmail() {
            return
        }
        
        var email = "mailto:\(destinationEmail)"
        
        if (StringUtils.isNotEmpty(subject)) {
            email = "\(email)?subject=\(subject)"
        }
        
        if (StringUtils.isNotEmpty(body)) {
            email = "\(email)&body=\(body)"
        }
        
        if let addedPercent = email.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) {
            if let nsurl = URL(string: addedPercent) {
                
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(nsurl, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(nsurl)
                }
            }
        }
    }
    
    //MARK: - Mail Compose View Controller Delegate
    open func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
            case MFMailComposeResult.cancelled:
                delegate?.onEmailCancelled()
            
            case MFMailComposeResult.sent:
                delegate?.onEmailSuccessful()
            
            default:
                break
        }
        
        EmailUtils.openEmail = nil
        controller.dismiss(animated: true, completion: nil)
    }
}
