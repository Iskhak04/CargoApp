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
    
    func goToSignIn() {
        //go to sign in page
        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(SignInModuleBuilder.build(), animated: true)
    }
    
    func sendSuccessStatus() {
        //new user is registered, push to tab bar
        let mainTabBar = MainTabBarController()
        
        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(mainTabBar, animated: true)
    }
    
}
