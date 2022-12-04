//
//  ViewControllerDelegate.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

protocol ViewControllerDelegate where Self: Coordinator {
    func viewControllerWillDeinit()
}

extension ViewControllerDelegate {
    func viewControllerWillDeinit() {
        detachHandler()
    }
}
