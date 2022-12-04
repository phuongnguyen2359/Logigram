//
//  LoginCoordinator.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import UIKit

protocol LoginCoordinatorDelegate: AnyObject {
    func loginCoordinatorDidLoginSuccess(coordinator: Coordinator)
}

class LoginCoordinator: Coordinator {
    weak var delegate: LoginCoordinatorDelegate?

    override func makeViewController(payload: CoordinatorPayload? = nil) -> UIViewController {
        let loginVC = R.storyboard.login.loginViewController()!
        loginVC.viewModel = LoginViewModel()
        loginVC.delegate = self
        return loginVC
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func presentHomeVC(_ sender: LoginViewController) {
        delegate?.loginCoordinatorDidLoginSuccess(coordinator: self)
    }
}
