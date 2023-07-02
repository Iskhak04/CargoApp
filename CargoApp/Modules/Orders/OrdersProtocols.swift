//
//  OrdersProtocols.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

//Conforms View, Presenter -> View
protocol OrdersViewProtocol {
    
}

//Conforms Presenter, Interactor -> Presenter, View -> Presenter
protocol OrdersPresenterProtocol {
    
    //View -> Presenter
    func goToDetailedOrder()
    func fetchOrders()
    
    //Interactor -> Presenter
    
}

//Conforms Interactor, Presenter -> Interactor
protocol OrdersInteractorProtocol {
    func fetchOrders()
}

//Conforms Router, Presenter -> Router
protocol OrdersRouterProtocol {
    func goToDetailedOrder()
    
}
