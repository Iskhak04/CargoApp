//
//  UserTypeSelectionCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class UserTypeSelectionCell: UICollectionViewCell {
    
    lazy var buttonsView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var whoAreYouLabel: UILabel = {
        let view = UILabel()
        view.text = "Who are you?"
        view.textColor = .label
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 40)
        return view
    }()
    
    lazy var shipperButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 20
        configuration.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large))
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .label
        configuration.attributedTitle = try! AttributedString( NSAttributedString(string: "I'm a shipper", attributes: [.font: UIFont(name: Fonts.RobotoRegular.rawValue, size: 28)!, .foregroundColor: UIColor.white,]), including: AttributeScopes.UIKitAttributes.self)
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .label
        //button.addTarget(self, action: #selector(shipperButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var carrierButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 20
        configuration.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large))
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .label
        configuration.attributedTitle = try! AttributedString( NSAttributedString(string: "I'm a carrier", attributes: [.font: UIFont(name: Fonts.RobotoRegular.rawValue, size: 28)!, .foregroundColor: UIColor.white,]), including: AttributeScopes.UIKitAttributes.self)
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .label
        //button.addTarget(self, action: #selector(carrierButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var logoImageView: UIImageView = {
        let button = UIImageView()
        button.image = UIImage(named: "logo")
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc private func carrierButtonClicked() {
        print("click")
        
    }
    
    @objc private func shipperButtonClicked() {
        print("click")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            
            addSubview(whoAreYouLabel)
            whoAreYouLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(200)
                make.centerX.equalToSuperview()
            }
            
            addSubview(buttonsView)
            buttonsView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.height.equalTo(220)
                make.width.equalTo(300)
            }
            
            buttonsView.addSubview(shipperButton)
            shipperButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(300)
            }
            
            buttonsView.addSubview(carrierButton)
            carrierButton.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(100)
                make.width.equalTo(300)
            }
    }
}
