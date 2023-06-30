//
//  SignUpProtocols.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

//Conforms View, Presenter -> View
protocol SignUpViewProtocol {
    func sendErrorMessages(errors: [ErrorModel])
}

//Conforms Presenter, Interactor -> Presenter, View -> Presenter
protocol SignUpPresenterProtocol {
    
    //View -> Presenter
    func newUserData(user: User)
    func goToSignIn()
    
    //Interactor -> Presenter
    func sendErrorMessages(errors: [ErrorModel])
    func sendSuccessStatus()
}

//Conforms Interactor, Presenter -> Interactor
protocol SignUpInteractorProtocol {
    func newUserData(user: User)
}

//Conforms Router, Presenter -> Router
protocol SignUpRouterProtocol {
    func sendSuccessStatus()
    func goToSignIn()
}
