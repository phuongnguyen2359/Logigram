//
//  UIView+Extensions.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

extension UIView {
    func roundedView() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 6
        self.layer.masksToBounds = true
    }
}
