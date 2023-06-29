//
//  RegistrationModuleBuilder.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit

final class RegistrationModuleBuilder {
    
    func build() -> UIViewController {
        let view = RegistrationViewController()
        let presenter = RegistrationPresenter()
        let interactor = RegistrationInteractor()
        let router = RegistrationRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
    
}
