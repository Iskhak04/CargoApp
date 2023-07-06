//
//  AppCoordinator.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class AppCoordinator {
    
    private let window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }

    func start() {
        openRootViewController()
    }
    
    fileprivate func openRootViewController() {
        window?.rootViewController = UINavigationController(rootViewController: MainTabBarController())
    }
}

