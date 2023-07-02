//
//  SignInProtocols.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

//Conforms View, Presenter -> View
protocol SignInViewProtocol {
    func sendErrorMessages(errors: [ErrorModel])
}

//Conforms Presenter, Interactor -> Presenter, View -> Presenter
protocol SignInPresenterProtocol {
    
    //View -> Presenter
    func goToSignUp()
    func userSignIn(email: String, password: String)
    func goToForgotPassword()
    
    //Interactor -> Presenter
    func sendErrorMessages(errors: [ErrorModel])
    func signInWasSuccessful()
}

//Conforms Interactor, Presenter -> Interactor
protocol SignInInteractorProtocol {
    func userSignIn(email: String, password: String)
}

//Conforms Router, Presenter -> Router
protocol SignInRouterProtocol {
    func goToSignUp()
    func signInWasSuccessful()
    func goToForgotPassword()
}
