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
    
    func registerNewCarrier(carrier: Carrier) {
        interactor?.registerNewCarrier(carrier: carrier)
    }
    
    func registerNewShipper(shipper: Shipper) {
        interactor?.registerNewShipper(shipper: shipper)
    }
    
    func goToSignIn() {
        router?.goToSignIn()
    }
    
    func sendErrorMessages(errors: [ErrorModel]) {
        print(errors.count)
        view?.sendErrorMessages(errors: errors)
    }
    
    func sendSuccessStatus() {
        router?.sendSuccessStatus()
    }

    
}
