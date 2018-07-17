//
//  UIScrollViewExtension.swift
//  brasilsaude
//
//  Created by Squarebits on 09/05/18.
//  Copyright © 2018 Squarebits. All rights reserved.
//

import UIKit

extension UIScrollView {
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

