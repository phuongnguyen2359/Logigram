//
//  AppCoordinator.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import UIKit

class AppCoordinator: Coordinator {
    var window: UIWindow?
    
    override func start(sceneType: SceneType, payload: CoordinatorPayload? = nil) {
        if case .root(let window) = sceneType {
            self.window = window
            presentWellcomeScreen()
        } else {
            fatalError("AppCoordinator must be root type")
        }
    }
}

extension AppCoordinator {
    func presentWellcomeScreen() {
        if let window = window {
            let welcomeCoordinator = WellcomeCoordinator()
            welcomeCoordinator.delegate = self
            add(welcomeCoordinator)
            welcomeCoordinator.start(sceneType: .root(window))
        }
    }
    
    func presentHomeScreen() {
        if let window = window {
            let homeCoordinator = HomeCoordinator()
            homeCoordinator.delegate = self
            add(homeCoordinator)
            homeCoordinator.start(sceneType: .root(window))
        }
    }
}

//MARK: - WelcomeCoordinatorDelegate
extension AppCoordinator: WelcomeCoordinatorDelegate {
    func presentHomeScreen(coordinator: Coordinator) {
        remove(coordinator)
        presentHomeScreen()
    }
}

//MARK: - HomeCoordinatorDelegate
extension AppCoordinator: HomeCoordinatorDelegate {
    func presentWellcomeVC(coordinator: Coordinator) {
        remove(coordinator)
        presentWellcomeScreen()
    }
}
