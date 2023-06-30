//
//  SignUpInteractor.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

final class SignUpInteractor {
    
    var presenter: SignUpPresenterProtocol?
    
}

extension SignUpInteractor: SignUpInteractorProtocol {
    
    func newUserData(user: User) {
        let errors = validateUserData(user: user)
                
            if errors.count == 0 {
                //send success status to presenter and register new user
                presenter?.sendSuccessStatus()
            } else {
                //send error message to presenter
                presenter?.sendErrorMessages(errors: errors)
            }

    }
    
}

func validateUserData(user: User) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    //Checking username
    if user.username.isEmpty {
        errors.append(ErrorModel(error: .username, errorMessage: .emptyFields))
    } else if user.username == "username" {
        errors.append(ErrorModel(error: .username, errorMessage: .usernameIsNotAvailable))
    }
    
    //Checking email
    if user.email.isEmpty {
        errors.append(ErrorModel(error: .email, errorMessage: .emptyFields))
    } else if user.email == "email" {
        errors.append(ErrorModel(error: .email, errorMessage: .emailAlreadyRegistered))
    } else if user.email == "wrong" {
        errors.append(ErrorModel(error: .email, errorMessage: .wrongEmail))
    }
    
    //Checking password
    if user.password.isEmpty {
        errors.append(ErrorModel(error: .password, errorMessage: .emptyFields))
    } else if user.password == "wrong" {
        errors.append(ErrorModel(error: .password, errorMessage: .passwordDoesNotMeetRequirements))
    } else if user.password != user.repeatPassword {
        errors.append(ErrorModel(error: .password, errorMessage: .passwordsDoNotMatch))
    }
    
    //Checking repeat password
    if user.repeatPassword.isEmpty {
        errors.append(ErrorModel(error: .repeatPassword, errorMessage: .emptyFields))
    } else if user.repeatPassword != user.password {
        errors.append(ErrorModel(error: .repeatPassword, errorMessage: .passwordsDoNotMatch))
    }
    
    //Checking user type
    if user.userTypeInt < 0 {
        errors.append(ErrorModel(error: .userType, errorMessage: .didNotSelectUserType))
    }

    return errors
}
