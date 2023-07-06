//
//  ProfileViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

final class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenterProtocol?
    var user: UserModel?
    
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
    
    private lazy var userImageView: UIImageView = {
        let view = UIImageView()
//        view.image = UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large))
        view.image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .medium, scale: .large))
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        //view.layer.borderWidth = 1
        view.layer.cornerRadius = 40
        view.tintColor = .label
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
    
    private lazy var dotView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var mcView: UIView = {
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
        view.text = "DOT #"
        view.textColor = .systemGray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var dotLabel: UILabel = {
        let view = UILabel()
        view.text = "1234567"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var mcWordLabel: UILabel = {
        let view = UILabel()
        view.text = "MC #"
        view.textColor = .systemGray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var mcLabel: UILabel = {
        let view = UILabel()
        view.text = "123456"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var myVehiclesWordLabel: UILabel = {
        let view = UILabel()
        view.text = "My vehicles:"
        view.textColor = .systemGray
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var myVehiclesLabel: UILabel = {
        let view = UILabel()
        view.text = "3"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    private lazy var addVehicleButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(addVehicleButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var deleteVehicleButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "minus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(addVehicleButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var editVehicleButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(addVehicleButtonClicked), for: .touchUpInside)
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
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private lazy var signOutButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .white
        view.setTitle("Sign out", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(signOutButtonClicked), for: .touchUpInside)
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("hello")
        //userImageView.layer.borderColor = UIColor.label.cgColor
        userImageView.tintColor = .label
        myTrucksCollectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserData { realUser in
            self.user = realUser
            self.userCredentialsLabel.text = "\(self.user!.firstName) \(self.user!.lastName)"
            self.lifetimeLoadsLabel.text = "\(self.user!.ordersCount)"
            self.memberSinceLabel.text = "\(self.user!.memberSince)"
            self.dotLabel.text = "\(self.user!.dotNumber)"
            if self.user!.isShipper {
                self.dotView.isHidden = true
                self.userTypeLabel.text = "Shipper"
            } else {
                self.userTypeLabel.text = "Carrier"
            }
        }
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func fetchUserData(completion: @escaping (UserModel) -> Void) {
        let user = Auth.auth().currentUser
        
        let databaseRef = Database.database().reference(withPath: "users/\(user!.uid)")
        
        databaseRef.observe(.value) { snapshot in
            guard let jsonData = snapshot.value as? [String: Any] else { return }
            
            do {
                let userData = try JSONSerialization.data(withJSONObject: jsonData)
                
                let userRealData = try JSONDecoder().decode(UserModel.self, from: userData)
                print(userRealData.firstName)
                completion(userRealData)
            } catch {
                print("error fetching user data in profile vc:", error.localizedDescription)
            }
        }
    }
    
    @objc private func addVehicleButtonClicked() {
        
    }
    
    private func layout() {
        
        view.addSubview(userView)
        userView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(65)
        }

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
        
        userView.addSubview(userImageView)
        userImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
            make.width.equalTo(80)
            make.right.equalToSuperview()
        }
        
        view.addSubview(memberSinceView)
        memberSinceView.snp.makeConstraints { make in
            make.top.equalTo(userView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        
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
            make.top.equalTo(userView.snp.bottom).offset(30)
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
        
        view.addSubview(dotView)
        dotView.snp.makeConstraints { make in
            make.top.equalTo(lifetimeView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(170)
            make.height.equalTo(50)
        }
        
        dotView.addSubview(dotWordLabel)
        dotWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        dotView.addSubview(dotLabel)
        dotLabel.snp.makeConstraints { make in
            make.top.equalTo(dotWordLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
        }
        
//        view.addSubview(mcView)
//        mcView.snp.makeConstraints { make in
//            make.top.equalTo(lifetimeView.snp.bottom).offset(20)
//            make.left.equalTo(dotView.snp.right).offset(10)
//            make.right.equalToSuperview().offset(-20)
//            make.height.equalTo(50)
//        }
//
//        mcView.addSubview(mcWordLabel)
//        mcWordLabel.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.left.equalToSuperview()
//        }
//
//        mcView.addSubview(mcLabel)
//        mcLabel.snp.makeConstraints { make in
//            make.top.equalTo(mcWordLabel.snp.bottom).offset(5)
//            make.left.equalToSuperview()
//        }
        
        view.addSubview(myVehiclesWordLabel)
        myVehiclesWordLabel.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(myVehiclesLabel)
        myVehiclesLabel.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(40)
            make.left.equalTo(myVehiclesWordLabel.snp.right).offset(10)
        }
        
        view.addSubview(addVehicleButton)
        addVehicleButton.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(37)
            make.right.equalToSuperview().offset(-20)
        }
        
        view.addSubview(deleteVehicleButton)
        deleteVehicleButton.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(37)
            make.right.equalTo(addVehicleButton.snp.left).offset(5)
        }
        
        view.addSubview(editVehicleButton)
        editVehicleButton.snp.makeConstraints { make in
            make.top.equalTo(dotView.snp.bottom).offset(37)
            make.right.equalTo(deleteVehicleButton.snp.left).offset(5)
        }
        
        view.addSubview(myTrucksCollectionView)
        myTrucksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myVehiclesWordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(220)
        }
        
        view.addSubview(signOutButton)
        signOutButton.snp.makeConstraints { make in
            make.top.equalTo(myTrucksCollectionView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }
    
    @objc private func signOutButtonClicked() {
        try? Auth.auth().signOut()
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
        cell.vehicleIdLabel.text = "#\(indexPath.row + 1)"
        
        cell.bgView.backgroundColor = .systemBackground
        cell.bgView.layer.cornerRadius = 10
        cell.bgView.layer.shadowColor = UIColor.label.cgColor
        cell.bgView.layer.shadowRadius = 7
        cell.bgView.layer.shouldRasterize = true
        cell.bgView.layer.shadowOpacity = 0.7
        cell.bgView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.bgView.layer.cornerRadius = 10
        cell.bgView.layer.rasterizationScale = UIScreen.main.scale
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
