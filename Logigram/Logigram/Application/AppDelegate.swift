//
//  AppDelegate.swift
//  Logigram
//
//  Created by TT on 12/2/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow? 
    var appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        guard let window = window else { return false }
        appCoordinator.start(sceneType: .root(window))
    
        return true
    }
}
