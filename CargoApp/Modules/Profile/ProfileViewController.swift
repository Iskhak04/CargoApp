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
    
    private lazy var userView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var userCredentialsLabel: UILabel = {
        let view = UILabel()
        view.text = "Larry Anderson"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 30)
        return view
    }()
    
    private lazy var userTypeLabel: UILabel = {
        let view = UILabel()
        view.text = "Carrier"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 21)
        return view
    }()
    
    private lazy var userTypeImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "box.truck.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large))
        view.tintColor = .black
        return view
    }()
    
    private lazy var memberSinceView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var memberSinceWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Member since"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        view.textColor = .systemGray
        return view
    }()
    
    private lazy var memberSinceLabel: UILabel = {
        let view = UILabel()
        view.text = "Nov 2018"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var lifetimeView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var lifetimeLoadsWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Lifetime loads"
        view.textColor = .systemGray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var lifetimeLoadsLabel: UILabel = {
        let view = UILabel()
        view.text = "15"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var dotWordLabel: UILabel = {
        let view = UILabel()
        view.text = "DOT"
        return view
    }()
    
    private lazy var dotLabel: UILabel = {
        let view = UILabel()
        view.text = "1234567"
        return view
    }()
    
    private lazy var mcWordLabel: UILabel = {
        let view = UILabel()
        view.text = "MC"
        return view
    }()
    
    private lazy var mcLabel: UILabel = {
        let view = UILabel()
        view.text = "123456"
        return view
    }()
    
    private lazy var myTrucksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        view.isPagingEnabled = true
        view.register(MyTrucksCollectionViewCell.self, forCellWithReuseIdentifier: "MyTrucksCollectionViewCell")
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    private lazy var signOutButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .systemRed
        view.setTitle("Sign out", for: .normal)
        view.setTitleColor(.systemRed, for: .normal)
        view.addTarget(self, action: #selector(signOutButtonClicked), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
        print(view.frame.width)
    }
    
    private func layout() {
        
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(65)
        }
        userView.backgroundColor = .orange
        
        userView.addSubview(userCredentialsLabel)
        userCredentialsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        userView.addSubview(userTypeLabel)
        userTypeLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        userView.addSubview(userTypeImageView)
        userTypeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.height.equalToSuperview()
//            make.width.equalTo(userView.snp.height).offset(20)
            make.right.equalToSuperview()
        }
        
        view.addSubview(memberSinceView)
        memberSinceView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(60)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        memberSinceView.backgroundColor = .cyan
        lifetimeView.backgroundColor = .yellow
        
        memberSinceView.addSubview(memberSinceWordLabel)
        memberSinceWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        memberSinceView.addSubview(memberSinceLabel)
        memberSinceLabel.snp.makeConstraints { make in
            make.top.equalTo(memberSinceWordLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
        }
        
        view.addSubview(lifetimeView)
        lifetimeView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(60)
            make.left.equalTo(memberSinceView.snp.right).offset(10)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(50)
        }
        
        lifetimeView.addSubview(lifetimeLoadsWordLabel)
        lifetimeLoadsWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        lifetimeView.addSubview(lifetimeLoadsLabel)
        lifetimeLoadsLabel.snp.makeConstraints { make in
            make.top.equalTo(lifetimeLoadsWordLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
        }
        
        view.addSubview(myTrucksCollectionView)
        myTrucksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(lifetimeView.snp.bottom).offset(60)
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
    }
    
    @objc private func signOutButtonClicked() {
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

extension ProfileViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = myTrucksCollectionView.dequeueReusableCell(withReuseIdentifier: "MyTrucksCollectionViewCell", for: indexPath) as! MyTrucksCollectionViewCell
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

extension ProfileViewController: ProfileViewProtocol {
    
}
