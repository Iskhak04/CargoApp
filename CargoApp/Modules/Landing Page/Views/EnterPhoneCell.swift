//
//  EnterPhoneCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class EnterPhoneCell: UICollectionViewCell {
    
    lazy var enterYourPhoneLabel: UILabel = {
        let view = UILabel()
        view.text = "Enter your phone number"
        view.textColor = .label
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 25)
        return view
    }()
    
    lazy var phoneTextField: UITextField = {
        let view = UITextField()
        
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
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(enterYourPhoneLabel)
        enterYourPhoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(enterYourPhoneLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        addSubview(continueButton)
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(200)
        }
    }
}
