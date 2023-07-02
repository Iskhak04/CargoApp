//
//  ProfileViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit
import FirebaseDatabase

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    
    private lazy var callShipperButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemGreen
        view.addTarget(self, action: #selector(callShipperButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 35
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        view.addSubview(callShipperButton)
        callShipperButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(100)
        }
    }
    
    @objc private func callShipperButtonClicked() {
        fetchProfileData()
        
    }
    
    func fetchProfileData() {
        var ref = Database.database().reference()
        
        var child = ref.child("user")
        
        child.observeSingleEvent(of: .value) { snapshot in
            do {
                let object = try snapshot.data(as: UserModel.self)
                print(object.firstName)
            } catch {
                
            }
            
        }
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
}
