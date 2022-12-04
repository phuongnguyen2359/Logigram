//
//  HomeCoordinator.swift
//  Logigram
//
//  Created by TT on 12/3/22.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func presentWellcomeVC(coordinator: Coordinator)
}

class HomeCoordinator: Coordinator {

    weak var delegate: HomeCoordinatorDelegate?

    override func makeViewController(payload: CoordinatorPayload? = nil) -> UIViewController {
        guard let homeVC = R.storyboard.home.homeViewController() else { return UIViewController() }
        homeVC.delegate = self
        return homeVC
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
    func presentWellcomeVC(_ sender: HomeViewController) {
        delegate?.presentWellcomeVC(coordinator: self)
    }
}
