//
//  DetailedOrderModuleBuilder.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 01.07.23.
//

import UIKit

final class DetailedOrderModuleBuilder {
    class func build() -> UIViewController {
        let view = DetailedOrderViewController()
        let presenter = DetailedOrderPresenter()
        let interactor = DetailedOrderInteractor()
        let router = DetailedOrderRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
