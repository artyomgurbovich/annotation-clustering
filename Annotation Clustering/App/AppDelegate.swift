//
//  AppDelegate.swift
//  Annotation Clustering
//
//  Created by Artyom Gurbovich on 9.03.22.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        coordinator = AppCoordinator(navigationController: navigationController)
        coordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
