//
//  EnterEmailCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class EnterEmailCell: UICollectionViewCell {
    
    var userVC: UserTypeSelectionViewController?
    
    lazy var enterYourEmailLabel: UILabel = {
        let view = UILabel()
        view.text = "Enter your email"
        view.textColor = .label
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 30)
        return view
    }()
    
    lazy var emailTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 10, height: 20)
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Email"
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.keyboardType = .numberPad
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.leftView = emailTextFieldPaddingView
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
        guard let email = emailTextField.text else { return }
        
        if email.isEmpty {
            emailTextField.layer.borderColor = UIColor.systemRed.cgColor
        } else {
            emailTextField.layer.borderColor = UIColor.black.cgColor
            userVC?.email = email
            userVC?.pagesCollectionVeiw.scrollToItem(at: IndexPath(row: 2, section: 0), at: [], animated: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(enterYourEmailLabel)
        enterYourEmailLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(140)
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(enterYourEmailLabel.snp.bottom).offset(50)
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
