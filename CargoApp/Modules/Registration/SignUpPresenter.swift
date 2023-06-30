//
//  SignUpPresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

final class SignUpPresenter {
    
    var view: SignUpViewProtocol?
    var interactor: SignUpInteractorProtocol?
    var router: SignUpRouterProtocol?
    
}

extension SignUpPresenter: SignUpPresenterProtocol {
    
    func sendErrorMessages(errors: [ErrorModel]) {
        view?.sendErrorMessages(errors: errors)
    }
    
    func sendSuccessStatus() {
        router?.sendSuccessStatus()
    }
    
    func newUserData(user: User) {
        interactor?.newUserData(user: user)
    }
    
}
