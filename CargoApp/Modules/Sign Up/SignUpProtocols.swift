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
    func registerNewCarrier(carrier: Carrier)
    func registerNewShipper(shipper: Shipper)
    func goToSignIn()
    
    //Interactor -> Presenter
    func sendErrorMessages(errors: [ErrorModel])
    func sendSuccessStatus()
}

//Conforms Interactor, Presenter -> Interactor
protocol SignUpInteractorProtocol {
    func registerNewCarrier(carrier: Carrier)
    func registerNewShipper(shipper: Shipper)
}

//Conforms Router, Presenter -> Router
protocol SignUpRouterProtocol {
    func sendSuccessStatus()
    func goToSignIn()
}
