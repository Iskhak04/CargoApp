//
//  SignInViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class SignInViewController: UIViewController {
    
    var presenter: SignInPresenterProtocol?
    
    private lazy var signInTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign In"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 35)
        view.textColor = .label
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
    
    private lazy var revealPasswordButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .black
        view.addTarget(self, action: #selector(revealPasswordButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var signUpView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var doNotHaveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account?"
        label.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        button.setTitleColor(Constants.shared.mainColor, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Constants.shared.mainColor
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let view = UIButton()
        view.setTitle("Forgot password?", for: .normal)
        view.setTitleColor(Constants.shared.mainColor, for: .normal)
        view.titleLabel?.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        view.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        return view
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        layout()
    }
    
    @objc func forgotPasswordButtonClicked() {
        presenter?.goToForgotPassword()
    }
    
    @objc private func revealPasswordButtonClicked() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc private func signUpButtonClicked() {
        presenter?.goToSignUp()
    }
    
    @objc private func signInButtonClicked() {
        
        usernameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        passwordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        
        usernameErrorLabel.text = ""
        passwordErrorLabel.text = ""

        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        
        presenter?.userSignIn(username: username, password: password)
    }
    
    private func layout() {
        view.addSubview(signInTitleLabel)
        signInTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(200)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(usernameTitleLabel)
        usernameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(signInTitleLabel.snp.bottom).offset(50)
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
        
        view.addSubview(passwordTitleLabel)
        passwordTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(35)
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
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(260)
        }
        
        view.addSubview(signUpView)
        signUpView.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-15)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.frame.width - 153)
            make.height.equalTo(23)
        }
        
        signUpView.addSubview(doNotHaveAnAccountLabel)
        doNotHaveAnAccountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        signUpView.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.left.equalTo(doNotHaveAnAccountLabel.snp.right).offset(5)
            make.centerY.equalToSuperview()
        }
    }
    
}

extension SignInViewController: SignInViewProtocol {
    
    func sendErrorMessages(errors: [ErrorModel]) {
        
        //notify about error
        for i in 0..<errors.count {
            switch errors[i].error {
            case .username:
                usernameTextField.layer.borderColor = UIColor.systemRed.cgColor
                usernameErrorLabel.text = errors[i].errorMessage.rawValue
            case .password:
                passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                passwordErrorLabel.text = errors[i].errorMessage.rawValue
            default:
                ()
            }
        }

    }
    
}
