//
//  EnterPhoneCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class EnterPhoneCell: UICollectionViewCell {
    
    var userVC: UserTypeSelectionViewController?
    let newDict = Countries.shared.swapKeyValues(of: Countries.shared.countryDictionary)
    static let path = Bundle.main.path(forResource: "Config", ofType: "plist")
    static let config = NSDictionary(contentsOfFile: path!)
    private let baseURLString = config!["serverUrl"] as! String
    
    func sendVerificationCode(_ countryCode: String, _ phoneNumber: String) {
            
        let parameters = [
            "via": "sms",
            "country_code": countryCode,
            "phone_number": phoneNumber
        ]
        
        let path = "start"
        let method = "POST"
        
        let urlPath = "\(baseURLString)/\(path)"
        var components = URLComponents(string: urlPath)!
        
        var queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        components.queryItems = queryItems
        
        let url = components.url!
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        let session: URLSession = {
            let config = URLSessionConfiguration.default
            return URLSession(configuration: config)
        }()
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            if let data = data {
                do {
                    let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    
                    print(jsonSerialized!)
                }  catch let error as NSError {
                    print(error.localizedDescription)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    lazy var enterYourPhoneLabel: UILabel = {
        let view = UILabel()
        view.text = "Enter your phone number"
        view.textColor = .label
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 30)
        return view
    }()
    
    lazy var countryPhoneCodeTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    lazy var countryFlagLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = .gray
        view.textAlignment = .center
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 25)
        let topBorder = CALayer()
        topBorder.borderColor = UIColor.black.cgColor;
        topBorder.borderWidth = 1;
        topBorder.frame = CGRect(x: 0, y: 0, width: 40, height: 1)
        view.layer.addSublayer(topBorder)

        let bottomBorder = CALayer()
        bottomBorder.borderColor = UIColor.black.cgColor;
        bottomBorder.borderWidth = 1;
        bottomBorder.frame = CGRect(x: 0, y: 39, width: 40, height: 1)
        view.layer.addSublayer(bottomBorder)
        
        let leftBorder = CALayer()
        leftBorder.borderColor = UIColor.black.cgColor;
        leftBorder.borderWidth = 1;
        leftBorder.frame = CGRect(x: 0, y: 0, width: 1, height: 40)
        view.layer.addSublayer(leftBorder)
        return view
    }()
    
    lazy var countryPhoneCodeTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Code"
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.keyboardType = .numberPad
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.delegate = self
        view.leftView = countryPhoneCodeTextFieldPaddingView
        view.leftViewMode = .always
        return view
    }()
    
    lazy var phoneTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    lazy var phoneTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Phone number"
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.keyboardType = .numberPad
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.delegate = self
        view.leftView = phoneTextFieldPaddingView
        view.leftViewMode = .always
        return view
    }()
    
    lazy var continueButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 20
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .label
        configuration.attributedTitle = try! AttributedString( NSAttributedString(string: "Continue", attributes: [.font: UIFont(name: Fonts.RobotoRegular.rawValue, size: 28)!, .foregroundColor: UIColor.white,]), including: AttributeScopes.UIKitAttributes.self)
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .label
        button.addTarget(self, action: #selector(continueButtonClicked), for: .touchUpInside)
        return button
    }()
    
    @objc func continueButtonClicked() {
        guard let phoneNumber = phoneTextField.text, let code = countryPhoneCodeTextField.text else { return }
        
        if code.isEmpty || countryFlagLabel.text == "❌" {
            countryPhoneCodeTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            countryPhoneCodeTextField.layer.borderColor = UIColor.label.cgColor
        }
        
        if phoneNumber.isEmpty {
            phoneTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            phoneTextField.layer.borderColor = UIColor.label.cgColor
        }
        
        if !code.isEmpty && countryFlagLabel.text != "❌" && !phoneNumber.isEmpty {
            phoneTextField.layer.borderColor = UIColor.label.cgColor
            countryPhoneCodeTextField.layer.borderColor = UIColor.label.cgColor
            userVC?.phoneNumber = Int(code + phoneNumber)
            userVC?.pagesCollectionVeiw.scrollToItem(at: IndexPath(row: 2, section: 0), at: [], animated: true)
            print(code)
            print(phoneNumber)
            sendVerificationCode("+\(code)", phoneNumber)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(enterYourPhoneLabel)
        enterYourPhoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview().offset(20)
        }
        addSubview(countryFlagLabel)
        countryFlagLabel.snp.makeConstraints { make in
            make.top.equalTo(enterYourPhoneLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(39)
            make.width.equalTo(40)
        }
        
        addSubview(countryPhoneCodeTextField)
        countryPhoneCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(enterYourPhoneLabel.snp.bottom).offset(50)
            make.left.equalTo(countryFlagLabel.snp.right).offset(0)
            make.height.equalTo(40)
            make.width.equalTo(80)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterYourPhoneLabel.snp.bottom).offset(50)
            make.left.equalTo(countryPhoneCodeTextField.snp.right).offset(5)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-20)
        }
        
        addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
}

extension EnterPhoneCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var result = true

        if string.count > 0 {
            let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
            let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
            result = replacementStringIsLegal
        }
        var maxLength = 10
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        if textField == countryPhoneCodeTextField {
            maxLength = 3
        }

        return newString.count <= maxLength && result
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField == countryPhoneCodeTextField {
            if let countryCode = newDict[countryPhoneCodeTextField.text!] {
                countryFlagLabel.text = Countries.shared.flag(country: countryCode)
            } else {
                countryFlagLabel.text = "❌"
            }
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let toolBar = UIToolbar()
        toolBar.barStyle = .black
        textField.inputAccessoryView = toolBar
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
