//
//  SignInRouter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class SignInRouter {
    
    weak var viewController: UIViewController?
    
}

extension SignInRouter: SignInRouterProtocol {
    
    func goToForgotPassword() {
        //go to forgot password page
    }
    
    func signInWasSuccessful() {
        //user successfully signed in, go to tab bar
        let mainTabBar = MainTabBarController()
        
        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(mainTabBar, animated: true)
    }
    
    func goToSignUp() {
        //go to sign up page
        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(SignUpModuleBuilder.build(), animated: true)
    }
    
}
