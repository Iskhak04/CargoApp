//
//  LandingPageViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class LandingPageViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "truck")
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create an account", for: .normal)
        button.titleLabel?.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    @objc private func signUpButtonClicked() {
        navigationController?.dismiss(animated: true)
        navigationController?.pushViewController(UserTypeSelectionViewController(), animated: true)
    }
    
    @objc private func signInButtonClicked() {
        
    }
    
    private func layout() {
        view.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-250)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(260)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(260)
        }
    }
}
