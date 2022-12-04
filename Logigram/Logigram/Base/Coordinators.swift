//
//  Coordinators.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import Foundation
import UIKit

enum SceneType {
    case root(UIWindow)
    case push(UINavigationController)
    case present(UIViewController)
    case presentInFullScreen(UIViewController)
}

protocol CoordinatorPayload {}

class Coordinator: NSObject {
    deinit {
        debugPrint("deinit \(type(of: self))")
    }
    
    var coordinators: [Coordinator] = []
    
    lazy var rootViewController: UIViewController = {
        return makeViewController()
    }()
    
    var detachHandler: (() -> Void) = { () in }
    
    func start(sceneType: SceneType, payload: CoordinatorPayload? = nil) {
        let viewController = makeViewController(payload: payload)
        rootViewController = viewController
        launch(target: viewController, sceneType: sceneType)
    }
    
    func makeViewController(payload: CoordinatorPayload? = nil) -> UIViewController {
        return UIViewController()
    }
    
    func add(_ coordinator: Coordinator) {
        coordinator.detachHandler = { [weak self, weak coordinator] in
            self?.remove(coordinator)
        }
        coordinators.append(coordinator)
    }
    
    func launch(target: UIViewController, sceneType: SceneType) {
        switch sceneType {
        case .present(let viewController):
            viewController.present(target, animated: true, completion: nil)
        case .push(let navigationController):
            navigationController.push(target, animated: true)
        case .presentInFullScreen(let viewController):
            viewController.presentInFullScreen(target, animated: true)
        case .root(let window):
            window.rootViewController = target
        }
    }
    
    func remove(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else { return }
        coordinators = coordinators.filter { $0 !== coordinator }
    }
    
    func removeAllCoordinators() {
        coordinators.removeAll()
    }
    
    func removeCoordinators<T: Coordinator>(type: T.Type) {
        coordinators = coordinators.filter { !($0.self is T)}
    }
    
    func firstChild<T: Coordinator>(of type: T.Type) -> T? {
        return coordinators.first(where: { $0 is T }) as? T
    }
}

extension UINavigationController {
    func push(_ viewController: UIViewController, animated: Bool) {
        var viewController: UIViewController? = viewController
        if let navigationController = viewController as? UINavigationController {
            viewController = navigationController.viewControllers.first
        }
        guard let targetViewController = viewController else { return }
        guard self.topViewController?.isKind(of: targetViewController.classForCoder) != true else { return }
        pushViewController(targetViewController, animated: animated)
    }
}

extension UIViewController {
    func presentInFullScreen(_ viewController: UIViewController,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: animated, completion: completion)
    }
}
