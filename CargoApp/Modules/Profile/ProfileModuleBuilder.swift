//
//  ProfileModuleBuilder.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class ProfileModuleBuilder {
    class func build() -> UIViewController {
        let view = ProfileViewController()
        let presenter = ProfilePresenter()
        let interactor = ProfileInteractor()
        let router = ProfileRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
