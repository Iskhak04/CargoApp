//
//  ProfilePresenter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

final class ProfilePresenter {
    
    var view: ProfileViewProtocol?
    var interactor: ProfileInteractorProtocol?
    var router: ProfileRouterProtocol?
    
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
}
