//
//  SignUpViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 29.06.23.
//

import UIKit
import SnapKit
import FirebaseStorage

final class SignUpViewController: UIViewController {
    
    var presenter: SignUpPresenterProtocol?
    
    
    private lazy var signUpTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Sign Up"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 40)
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
        view.addTarget(self, action: #selector(userTypeSegmentChanged), for: .valueChanged)
        view.backgroundColor = .white
        view.selectedSegmentIndex = 1
        return view
    }()
    
    private lazy var userTypeErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var firstNameTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "First Name"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var firstNameTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = firstNameTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var firstNameErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var lastNameTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Last Name"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var lastNameTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = lastNameTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var lastNameErrorLabel: UILabel = {
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
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
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
        view.delegate = self
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
        view.layer.cornerRadius = 7
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.isSecureTextEntry = true
        view.delegate = self
        return view
    }()
    
    private lazy var passwordBgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 7
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var passwordTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Password"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var passwordErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        return view
    }()
    
    private lazy var dotNumberTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = dotNumberTextFieldPaddingView
        view.leftViewMode = .always
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    private lazy var dotNumberTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "DOT Number"
        view.font = Constants.shared.labelAboveTextFieldFont
        view.isHidden = true
        return view
    }()
    
    private lazy var dotNumberTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var dotNumberErrorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemRed
        view.isHidden = true
        return view
    }()
    
    private lazy var revealPasswordButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .label
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
        print("view sign up")
        navigationItem.hidesBackButton = true
        view.backgroundColor = .systemBackground
        layout()
    }
    
    @objc private func userTypeSegmentChanged() {
        //user is a Carrier
        if userTypeSegmentedControl.selectedSegmentIndex == 0 {
            dotNumberTextField.isHidden = false
            dotNumberErrorLabel.isHidden = false
            dotNumberTitleLabel.isHidden = false
            dotNumberTextField.text = ""
            dotNumberErrorLabel.text = ""
            
            firstNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            lastNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            emailTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            passwordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            dotNumberTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            
            firstNameErrorLabel.text = ""
            lastNameErrorLabel.text = ""
            emailErrorLabel.text = ""
            passwordErrorLabel.text = ""
            userTypeErrorLabel.text = ""
            
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            dotNumberTextField.text = ""
        }
        //user is a Shipper
        else {
            dotNumberTextField.isHidden = true
            dotNumberErrorLabel.isHidden = true
            dotNumberTitleLabel.isHidden = true
            
            firstNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            lastNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            emailTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            passwordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            dotNumberTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
            
            firstNameErrorLabel.text = ""
            lastNameErrorLabel.text = ""
            emailErrorLabel.text = ""
            passwordErrorLabel.text = ""
            userTypeErrorLabel.text = ""
            
            firstNameTextField.text = ""
            lastNameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            dotNumberTextField.text = ""
        }
    }
                            
    @objc private func signInButtonClicked() {
        presenter?.goToSignIn()
    }
    
    @objc private func signUpButtonClicked() {
        
        firstNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        lastNameTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        emailTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        passwordTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        dotNumberTextField.layer.borderColor = Constants.shared.textFieldsBorderColor
        
        firstNameErrorLabel.text = ""
        lastNameErrorLabel.text = ""
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
        dotNumberErrorLabel.text = ""
        userTypeErrorLabel.text = ""
        
        //user is Carrier
        if userTypeSegmentedControl.selectedSegmentIndex == 0 {
            guard let firstName = firstNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let dotNumber = dotNumberTextField.text, let lastName = lastNameTextField.text else { return }
            
            let newCarrier = Carrier(firstName: firstName, lastName: lastName, email: email, password: password, dotNumber: Int(dotNumber) ?? -1)
            
            presenter?.registerNewCarrier(carrier: newCarrier)
        }
        //user is Shipper
        else {
            guard let firstName = firstNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text, let lastName = lastNameTextField.text else { return }
            
            let newShipper = Shipper(firstName: firstName, lastName: lastName, email: email, password: password)
            
            presenter?.registerNewShipper(shipper: newShipper)
        }
        
    
//        let storage = Storage.storage().reference().child("mal.jpg")
//        NetworkLayer.shared.uploadImage(UIImage(named: "driver")!, at: storage) { url in
//            print("success image driver")
//            print(url)
//        }
        
    }
    
    @objc private func revealPasswordButtonClicked() {
        if passwordTextField.isSecureTextEntry {
            revealPasswordButton.setImage(UIImage(systemName: "eye.slash", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        } else {
            revealPasswordButton.setImage(UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large)), for: .normal)
            passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
        }
        
    }
    
    private func layout() {
        view.addSubview(signUpTitleLabel)
        signUpTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(userTypeSegmentedControl)
        userTypeSegmentedControl.snp.makeConstraints { make in
            make.top.equalTo(signUpTitleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }

        view.addSubview(userTypeErrorLabel)
        userTypeErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(userTypeSegmentedControl.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }

        view.addSubview(firstNameTitleLabel)
        firstNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(userTypeSegmentedControl.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { make in
            make.top.equalTo(firstNameTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }

        view.addSubview(firstNameErrorLabel)
        firstNameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(lastNameTitleLabel)
        lastNameTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(firstNameTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make in
            make.top.equalTo(lastNameTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }

        view.addSubview(lastNameErrorLabel)
        lastNameErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(emailTitleLabel)
        emailTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(lastNameTextField.snp.bottom).offset(35)
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
        
        view.addSubview(passwordBgView)
        passwordBgView.snp.makeConstraints { make in
            make.top.equalTo(passwordTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }
        
        passwordBgView.addSubview(revealPasswordButton)
        revealPasswordButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.height.equalToSuperview()
            make.width.equalTo(passwordBgView.snp.height)
        }

        passwordBgView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.right.equalTo(revealPasswordButton.snp.left).offset(-10)
        }

        view.addSubview(passwordErrorLabel)
        passwordErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(dotNumberTitleLabel)
        dotNumberTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(35)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(dotNumberTextField)
        dotNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(dotNumberTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(35)
        }

        view.addSubview(dotNumberErrorLabel)
        dotNumberErrorLabel.snp.makeConstraints { make in
            make.top.equalTo(dotNumberTextField.snp.bottom).offset(5)
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

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}

extension SignUpViewController: SignUpViewProtocol {
    
    func sendErrorMessages(errors: [ErrorModel]) {
        
        for i in 0..<errors.count {
            switch errors[i].error {
            case .email:
                emailTextField.layer.borderColor = UIColor.systemRed.cgColor
                emailErrorLabel.text = errors[i].errorMessage.rawValue
            case .firstName:
                firstNameTextField.layer.borderColor = UIColor.systemRed.cgColor
                firstNameErrorLabel.text = errors[i].errorMessage.rawValue
            case .password:
                passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                passwordErrorLabel.text = errors[i].errorMessage.rawValue
            case .lastName:
                lastNameTextField.layer.borderColor = UIColor.systemRed.cgColor
                lastNameErrorLabel.text = errors[i].errorMessage.rawValue
            case .dotNumber:
                dotNumberTextField.layer.borderColor = UIColor.systemRed.cgColor
                dotNumberErrorLabel.text = errors[i].errorMessage.rawValue
            }
        }

    }
    
}
