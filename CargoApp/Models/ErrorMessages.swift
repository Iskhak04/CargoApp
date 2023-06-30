//
//  ErrorMessages.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

enum ErrorMessages: String {
    //registration
    case emptyFields = "Empty field(s)"
    
    //Error messages related with email
    case emailAlreadyRegistered = "This email is already registered"
    case wrongEmail = "Wrong email"
    
    //Error messages related with username
    case usernameIsNotAvailable = "This username is already taken"
    
    //Error messages related with password
    case passwordsDoNotMatch = "Passwords do not match"
    case passwordDoesNotMeetRequirements = "Password must consist of at least 8 characters"
    
    //Error messages related with user type
    case didNotSelectUserType = "Please select one option"
    
    //login
    case wrongUsername = "Wrong username"
    case wrongPassword = "Wrong password"
}

