//
//  SignUpInteractor.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import FirebaseAuth
import FirebaseDatabase

final class SignUpInteractor {
    
    var presenter: SignUpPresenterProtocol?
    
}

extension SignUpInteractor: SignUpInteractorProtocol {
    
    func registerNewCarrier(carrier: Carrier) {
        
        let errors = validateCarrierData(carrier: carrier)
        
        if errors.count == 0 {
            //send success status to presenter and register new carrier
            presenter?.sendSuccessStatus()
            
            Auth.auth().createUser(withEmail: carrier.email, password: carrier.password) { authDataResult, error in
                if error == nil {
                    let user = Auth.auth().currentUser
                    
                    let databaseRef = Database.database().reference(withPath: "users/\(user!.uid)")
                    
                    let registeredDate = getCurrentDate()
                    
                    databaseRef.child("firstName").setValue(carrier.firstName)
                    databaseRef.child("lastName").setValue(carrier.lastName)
                    databaseRef.child("isShipper").setValue(false)
                    databaseRef.child("dotNumber").setValue(carrier.dotNumber)
                    databaseRef.child("ordersCount").setValue(0)
                    databaseRef.child("memberSince").setValue(registeredDate)
                    
                }
            }
            
        } else {
            //send error message to presenter
            presenter?.sendErrorMessages(errors: errors)
        }
    }
    
    func registerNewShipper(shipper: Shipper) {
        let errors = validateShipperData(shipper: shipper)
        
        if errors.count == 0 {
            //send success status to presenter and register new shipper
            presenter?.sendSuccessStatus()
            
            Auth.auth().createUser(withEmail: shipper.email, password: shipper.password) { authDataResult, error in
                if error == nil {
                    let user = Auth.auth().currentUser
                    
                    let databaseRef = Database.database().reference(withPath: "users/\(user!.uid)")
                    
                    let registeredDate = getCurrentDate()
                    
                    databaseRef.child("firstName").setValue(shipper.firstName)
                    databaseRef.child("lastName").setValue(shipper.lastName)
                    databaseRef.child("isShipper").setValue(true)
                    databaseRef.child("dotNumber").setValue(-1)
                    databaseRef.child("ordersCount").setValue(0)
                    databaseRef.child("memberSince").setValue(registeredDate)
                }
            }
        } else {
            //send error message to presenter
            presenter?.sendErrorMessages(errors: errors)
        }
    }
    
}

func getCurrentDate() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy"
    let yearString = dateFormatter.string(from: date)
    
    let date2 = Date()
    let dateFormatter2 = DateFormatter()
    dateFormatter2.dateFormat = "MMMM"
    let monthString = dateFormatter2.string(from: date2)
    
    return "\(monthString) \(yearString)"
}

func validateShipperData(shipper: Shipper) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    //Checking first name
    if shipper.firstName.isEmpty {
        errors.append(ErrorModel(error: .firstName, errorMessage: .emptyFields))
    }
    
    //Checking last name
    if shipper.lastName.isEmpty {
        errors.append(ErrorModel(error: .lastName, errorMessage: .emptyFields))
    }
    
    //Checking email
    if shipper.email.isEmpty {
        errors.append(ErrorModel(error: .email, errorMessage: .emptyFields))
    }
    
    //Checking password
    if shipper.password.isEmpty {
        errors.append(ErrorModel(error: .password, errorMessage: .emptyFields))
    }

    return errors
}

func validateCarrierData(carrier: Carrier) -> [ErrorModel] {
    var errors: [ErrorModel] = []
    
    //Checking first name
    if carrier.firstName.isEmpty {
        errors.append(ErrorModel(error: .firstName, errorMessage: .emptyFields))
    }
    
    //Checking last name
    if carrier.lastName.isEmpty {
        errors.append(ErrorModel(error: .lastName, errorMessage: .emptyFields))
    }
    
    //Checking email
    if carrier.email.isEmpty {
        errors.append(ErrorModel(error: .email, errorMessage: .emptyFields))
    }
    
    //Checking password
    if carrier.password.isEmpty {
        errors.append(ErrorModel(error: .password, errorMessage: .emptyFields))
    }
    
    //Checking dot Number
    if carrier.dotNumber == -1 {
        errors.append(ErrorModel(error: .dotNumber, errorMessage: .emptyFields))
    }
    

    return errors
}
