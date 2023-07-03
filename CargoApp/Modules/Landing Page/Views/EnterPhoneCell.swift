//
//  EnterPhoneCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class EnterPhoneCell: UICollectionViewCell {
    
    var userVC: UserTypeSelectionViewController?
    
    lazy var enterYourPhoneLabel: UILabel = {
        let view = UILabel()
        view.text = "Enter your phone number"
        view.textColor = .label
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 30)
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
        guard let phoneNumber = phoneTextField.text else { return }
        
        if phoneNumber.isEmpty {
            phoneTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            phoneTextField.layer.borderColor = UIColor.black.cgColor
            userVC?.phoneNumber = Int(phoneNumber)
            userVC?.pagesCollectionVeiw.scrollToItem(at: IndexPath(row: 2, section: 0), at: [], animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(enterYourPhoneLabel)
        enterYourPhoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterYourPhoneLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(frame.width - 100)
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
        let maxLength = 1
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return result
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
