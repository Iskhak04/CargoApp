//
//  SignInInteractor.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import FirebaseAuth

final class SignInInteractor {
    
    var presenter: SignInPresenterProtocol?
    
}

extension SignInInteractor: SignInInteractorProtocol {
    
    func userSignIn(email: String, password: String) {
        //here we check if the user exists, and if the username and password are correct
        let errors = validateUserData(email: email, password: password)
        
        
        if errors.count == 0 {
            
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if authResult?.user.email == email {
                    //send success status to presenter
                    self.presenter?.signInWasSuccessful()
                }
            }
            
        } else {
            //send error message to presenter
            presenter?.sendErrorMessages(errors: errors)
        }

    }
    
}

func validateUserData(email: String, password: String) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    //Checking email
    if email.isEmpty {
        errors.append(ErrorModel(error: .email, errorMessage: .emptyFields))
    }
    
    //Checking password
    if password.isEmpty {
        errors.append(ErrorModel(error: .password, errorMessage: .emptyFields))
    }

    return errors
}
