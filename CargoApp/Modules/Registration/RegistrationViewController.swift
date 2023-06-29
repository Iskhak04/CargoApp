//
//  RegistrationViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit

final class RegistrationViewController: UIViewController {
    
    var presenter: RegistrationPresenterProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
    }
}

extension RegistrationViewController: RegistrationViewProtocol {
    
}
