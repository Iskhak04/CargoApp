//
//  OrdersPresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

final class OrdersPresenter {
    
    var view: OrdersViewProtocol?
    var interactor: OrdersInteractorProtocol?
    var router: OrdersRouterProtocol?
    
}

extension OrdersPresenter: OrdersPresenterProtocol {
    
    func fetchOrders() {
        interactor?.fetchOrders()
    }
    
    func goToDetailedOrder(order: [String:Any]) {
        router?.goToDetailedOrder(order: order)
    }
    
}
