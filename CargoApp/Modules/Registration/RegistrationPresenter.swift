//
//  RegistrationPresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

final class RegistrationPresenter {
    
    var view: RegistrationViewProtocol?
    var interactor: RegistrationInteractorProtocol?
    var router: RegistrationRouterProtocol?
    
}

extension RegistrationPresenter: RegistrationPresenterProtocol {
    
}
