//
//  MainTabBarController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit
import CoreLocation

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .label
        tabBar.backgroundColor = .systemBackground
        navigationItem.hidesBackButton = true
        addVCs()
    }
    
    func addVCs() {
        viewControllers = [setupVCs(viewController: OrdersModuleBuilder.build(), image: UIImage(systemName: "list.clipboard")!, title: "Orders"), setupVCs(viewController: ProfileModuleBuilder.build(), image: UIImage(systemName: "person.fill")!, title: "Profile"), setupVCs(viewController: ViewController(), image: UIImage(systemName: "bolt")!, title: "Navigation")]
    }
    
    func setupVCs(viewController: UIViewController, image: UIImage, title: String) -> UIViewController {
        viewController.tabBarItem.image = image
        viewController.tabBarItem.title = title

        return viewController
    }
}
