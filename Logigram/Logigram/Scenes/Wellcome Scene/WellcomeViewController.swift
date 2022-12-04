//
//  WellcomeViewController.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit


protocol WellcomeViewControllerDelegate: ViewControllerDelegate {
    func presentSignInVC(_ sender: WellcomeViewController)
}

class WellcomeViewController: BaseViewController {

    weak var delegate: WellcomeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func willDeinit() {
        delegate?.viewControllerWillDeinit()
    }
}

//MARK: - Handle Actions
extension WellcomeViewController {
    @IBAction func onSignIn() {
        delegate?.presentSignInVC(self)
    }
}
