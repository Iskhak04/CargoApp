//
//  SignUpViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit
import SnapKit

final class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    private lazy var registrationTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign Up"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 35)
        view.textColor = .label
        return view
    }()
    
    private lazy var userTypeSegmentedControl: UISegmentedControl = {
        let view = UISegmentedControl()
        view.insertSegment(withTitle: "I'm a Carrier", at: 0, animated: true)
        view.insertSegment(withTitle: "I'm a Shipper", at: 1, animated: true)
        view.setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: Fonts.RobotoRegular.rawValue, size: 18)!, NSAttributedString.Key.foregroundColor : UIColor.black], for: .normal)
        view.selectedSegmentTintColor = Constants.shared.mainColor
        view.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected)
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var userTypeErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var usernameTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Username"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var usernameTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    private lazy var usernameTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = usernameTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        return view
    }()
    
    private lazy var usernameErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var emailTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Email"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var emailTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    private lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = emailTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        return view
    }()
    
    private lazy var emailErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var passwordTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = passwordTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.isSecureTextEntry = true
        view.rightView = revealPasswordButton
        view.rightViewMode = .always
        return view
    }()
    
    private lazy var passwordTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Password"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var passwordTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = repeatPasswordTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.isSecureTextEntry = true
        return view
    }()
    
    private lazy var repeatPasswordTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Repeat Password"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var repeatPasswordTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    private lazy var repeatPasswordErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var revealPasswordButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(revealPasswordButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var signInView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Have an account?"
        label.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        button.setTitleColor(Constants.shared.mainColor, for: .normal)
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.shared.mainColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
                            
    @objc private func signInButtonClicked() {
            
    }
    
    @objc private func signUpButtonClicked() {
        
        usernameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        emailTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        passwordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        repeatPasswordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        
        usernameErrorLabel.text = ""
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
        repeatPasswordErrorLabel.text = ""
        userTypeErrorLabel.text = ""
        
        guard let username = usernameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let repeatPassword = repeatPasswordTextField.text else { return }
        
        //sending new user data to presenter
        presenter?.newUserData(user: User(username: username, email: email, password: password, repeatPassword: repeatPassword, userTypeInt: userTypeSegmentedControl.selectedSegmentIndex))
        
    }
    
    @objc private func revealPasswordButtonClicked() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    private func layout() {
        view.addSubview(registrationTitleLabel)
        registrationTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(userTypeSegmentedControl)
        userTypeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(registrationTitleLabel.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(userTypeErrorLabel)
        userTypeErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(userTypeSegmentedControl.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameTitleLabel)
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userTypeSegmentedControl.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(usernameErrorLabel)
        usernameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(emailTitleLabel)
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(emailErrorLabel)
        emailErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(repeatPasswordTitleLabel)
        repeatPasswordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(repeatPasswordTextField)
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        view.addSubview(repeatPasswordErrorLabel)
        repeatPasswordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(260)
        }
        
        view.addSubview(signInView)
        signInView.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-15)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 204)
            make.height.equalTo(23)
        }
        
        signInView.addSubview(haveAnAccountLabel)
        haveAnAccountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        signInView.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.left.equalTo(haveAnAccountLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
        
        
        
    }
}

extension SignUpViewController: SignUpViewProtocol {
    
    func sendErrorMessages(errors: [ErrorModel]) {
        
        for i in 0..<errors.count {
            switch errors[i].error {
            case .email:
                emailTextField.layer.borderColor = UIColor.systemRed.cgColor
                emailErrorLabel.text = errors[i].errorMessage.rawValue
            case .username:
                usernameTextField.layer.borderColor = UIColor.systemRed.cgColor
                usernameErrorLabel.text = errors[i].errorMessage.rawValue
            case .password:
                passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                passwordErrorLabel.text = errors[i].errorMessage.rawValue
            case .repeatPassword:
                repeatPasswordTextField.layer.borderColor = UIColor.systemRed.cgColor
                repeatPasswordErrorLabel.text = errors[i].errorMessage.rawValue
            case .userType:
                userTypeErrorLabel.text = errors[i].errorMessage.rawValue
            }
        }

    }
    
}
