//
//  MainTabBarController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        addVCs()
    }
    
    func addVCs() {
        viewControllers = []
    }
    
    func setupVCs(viewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title
        

        return viewController
    }
}
