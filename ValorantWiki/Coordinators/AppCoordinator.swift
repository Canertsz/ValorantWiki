//
//  AppCoordinator.swift
//  ValorantWiki
//
//  Created by Caner Tüysüz on 13.02.2025.
//

import UIKit
import Hero

final class AppCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(window: UIWindow) {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController?.hero.isEnabled = true
        let homepageCoordinator = HomepageCoordinator(navigationController: navigationController)
        homepageCoordinator.start()
    }
}
