//
//  DetailedOrderPresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 01.07.23.
//

final class DetailedOrderPresenter {
    
    var interactor: DetailedOrderInteractorProtocol?
    var view: DetailedOrderViewProtocol?
    var router: DetailedOrderRouterProtocol?
    
}

extension DetailedOrderPresenter: DetailedOrderPresenterProtocol {
    
}
