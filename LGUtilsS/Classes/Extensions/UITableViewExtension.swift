//
//  UITableViewExtension.swift
//  brasilsaude
//
//  Created by Squarebits on 14/05/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UITableView {
    
   public func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
        self.separatorStyle = .none;
    }
    
    public func restore() {
        self.backgroundView = nil
//        self.separatorStyle = .singleLine
    }
    
   public func scrollToFirstRow(animated:Bool) {
        let indexPath = IndexPath(row: 0, section: 0)
        scrollToRow(at: indexPath as IndexPath, at: .top, animated: animated)
    }
    
   public func scrollToLastRow(animated:Bool, count:Int) {
        let indexPath = IndexPath(row: count - 1, section: 0)
        scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: animated)
    }
    
    public func scrollToSelectedRow(animated:Bool) {
        let selectedRows = indexPathsForSelectedRows
        if let selectedRow = selectedRows?[0] {
            scrollToRow(at: selectedRow, at: .middle, animated: animated)
        }
    }
    
   public func scrollToHeader(animated:Bool) {
        scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: animated)
    }
    
   public func scrollToTop(animated:Bool){
        setContentOffset(.zero, animated: animated)
    }
    
   public func disableScrollsToTopPropertyOnAllSubviewsOf(view: UIView) {
        for subview in view.subviews {
            if let scrollView = subview as? UIScrollView {
                (scrollView as UIScrollView).scrollsToTop = false
            }
            self.disableScrollsToTopPropertyOnAllSubviewsOf(view: subview as UIView)
        }
    }
    
}
