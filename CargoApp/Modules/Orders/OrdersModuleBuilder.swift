//
//  OrdersModuleBuilder.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrdersModuleBuilder {
    class func build() -> UIViewController {
        let view = OrdersViewController()
        let presenter = OrdersPresenter()
        let interactor = OrdersInteractor()
        let router = OrdersRouter()
        
        view.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        
        interactor.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
