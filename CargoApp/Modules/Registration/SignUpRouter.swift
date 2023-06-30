//
//  SignUpRouter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit

final class SignUpRouter {
    
    weak var viewController: UIViewController?
    
}

extension SignUpRouter: SignUpRouterProtocol {
    
    func sendSuccessStatus() {
        //new user is registered, push to tab bar
        let mainTabBar = MainTabBarController()
        print("hello")
        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(mainTabBar, animated: true)
    }
    
}
