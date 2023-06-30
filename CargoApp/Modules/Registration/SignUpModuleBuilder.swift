//
//  SignUpModuleBuilder.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit

final class SignUpModuleBuilder {
    
    func build() -> UIViewController {
        let view = SignUpViewController()
        let presenter = SignUpPresenter()
        let interactor = SignUpInteractor()
        let router = SignUpRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
    
}
