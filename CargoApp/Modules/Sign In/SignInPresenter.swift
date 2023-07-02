//
//  SignInPresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

final class SignInPresenter {
    
    var view: SignInViewProtocol?
    var interactor: SignInInteractorProtocol?
    var router: SignInRouterProtocol?
    
}

extension SignInPresenter: SignInPresenterProtocol {
    
    func goToForgotPassword() {
        router?.goToForgotPassword()
    }
    
    func sendErrorMessages(errors: [ErrorModel]) {
        view?.sendErrorMessages(errors: errors)
    }
    
    func signInWasSuccessful() {
        router?.signInWasSuccessful()
    }
    
    func userSignIn(email: String, password: String) {
        interactor?.userSignIn(email: email, password: password)
    }
    
    func goToSignUp() {
        router?.goToSignUp()
    }
    
}
