//
//  WellcomeCoordinator.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

protocol WelcomeCoordinatorDelegate: AnyObject {
    func presentHomeScreen(coordinator: Coordinator)
}

class WellcomeCoordinator: Coordinator {

    weak var delegate: WelcomeCoordinatorDelegate?

    override func makeViewController(payload: CoordinatorPayload? = nil) -> UIViewController {
        let welcomeVC = R.storyboard.wellcome.wellcomeViewController()!
        let navigationVC = UINavigationController(rootViewController: welcomeVC)
        welcomeVC.delegate = self
        return navigationVC
    }
}

extension WellcomeCoordinator: WellcomeViewControllerDelegate {
    func presentSignInVC(_ sender: WellcomeViewController) {
        guard let navigationVC = sender.navigationController else { return }
        let loginCoordinator = LoginCoordinator()
        loginCoordinator.delegate = self
        add(loginCoordinator)
        loginCoordinator.start(sceneType: .push(navigationVC))
    }
}

extension WellcomeCoordinator: LoginCoordinatorDelegate {
    func loginCoordinatorDidLoginSuccess(coordinator: Coordinator) {
        remove(coordinator)
        delegate?.presentHomeScreen(coordinator: self)
    }
}
