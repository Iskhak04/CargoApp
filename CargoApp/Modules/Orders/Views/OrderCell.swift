//
//  OrderCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrderCell: UICollectionViewCell {
    
    lazy var pickUpDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick Up - 30 Jun"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 20)
        return view
    }()
    
    lazy var pickUpView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var pickUpIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemGreen
        return view
    }()
    
    lazy var pickUpWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick up"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 16)
        view.textColor = .gray
        return view
    }()
    
    lazy var pickUpAddressLabel: UILabel = {
        let view = UILabel()
        view.text = "Birmingham, AL 35203"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 18)
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    lazy var dropOffView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var dropOffIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemRed
        return view
    }()
    
    lazy var dropOffWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Drop off"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 16)
        view.textColor = .gray
        return view
    }()
    
    lazy var dropOffAddressLabel: UILabel = {
        let view = UILabel()
        view.text = "Lometa, TX 76853"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 18)
        return view
    }()
    
    lazy var distanceView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var distanceIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "map", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large))
        view.tintColor = .gray
        return view
    }()
    
    lazy var distanceLabel: UILabel = {
        let view = UILabel()
        view.text = "1907 mi"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    lazy var vehicleTypeView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var vehicleTypeIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "box.truck", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large))
        view.tintColor = .gray
        return view
    }()
    
    lazy var vehicleTypeLabel: UILabel = {
        let view = UILabel()
        view.text = "Flatbed"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    lazy var loadWeightView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var loadWeightIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "scalemass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large))
        view.tintColor = .gray
        return view
    }()
    
    lazy var loadWeightLabel: UILabel = {
        let view = UILabel()
        view.text = "47k lbs"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.text = "$1290"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 22)
        view.textColor = .systemGreen
        return view
    }()
    
    lazy var shipperInformationView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var shipperWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Shipper"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 15)
        view.textColor = .gray
        return view
    }()
    
    lazy var shipperLabel: UILabel = {
        let view = UILabel()
        view.text = "Chrissy Dorsey"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    lazy var callShipperButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .large)), for: .normal)
        view.setTitle("CALL", for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemGreen
        view.addTarget(self, action: #selector(callShipperButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 20
        return view
    }()
    
    @objc func callShipperButtonClicked() {
        guard let number = URL(string: "tel://996704728104") else { return }
        UIApplication.shared.open(number)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
        addSubview(pickUpDateLabel)
        pickUpDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
//        ageView.addSubview(priceLabel)
//        priceLabel.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
//        }
        
        addSubview(pickUpView)
        pickUpView.snp.makeConstraints { make in
            make.top.equalTo(pickUpDateLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        
        pickUpView.addSubview(pickUpIconImageView)
        pickUpIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        
        pickUpView.addSubview(pickUpWordLabel)
        pickUpWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        pickUpView.addSubview(pickUpAddressLabel)
        pickUpAddressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        addSubview(dropOffView)
        dropOffView.snp.makeConstraints { make in
            make.top.equalTo(pickUpView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(5)
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        
        dropOffView.addSubview(dropOffIconImageView)
        dropOffIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        
        dropOffView.addSubview(dropOffWordLabel)
        dropOffWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dropOffIconImageView.snp.right).offset(5)
        }
        
        dropOffView.addSubview(dropOffAddressLabel)
        dropOffAddressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pickUpView.snp.bottom).offset(0)
            make.bottom.equalTo(dropOffView.snp.top).offset(0)
            make.width.equalTo(2)
            make.left.equalToSuperview().offset(28)
        }
        
        addSubview(distanceView)
        distanceView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(pickUpDateLabel.snp.bottom).offset(15)
            make.height.equalTo(25)
            make.width.equalTo(120)
        }
        
        distanceView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        distanceView.addSubview(distanceIconImageView)
        distanceIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(distanceLabel.snp.left).offset(-10)
        }
        
        addSubview(vehicleTypeView)
        vehicleTypeView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(distanceView.snp.bottom).offset(8)
            make.height.equalTo(25)
            make.width.equalTo(120)
        }
        
        vehicleTypeView.addSubview(vehicleTypeLabel)
        vehicleTypeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        vehicleTypeView.addSubview(vehicleTypeIconImageView)
        vehicleTypeIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(vehicleTypeLabel.snp.left).offset(-10)
        }
        
        addSubview(loadWeightView)
        loadWeightView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(vehicleTypeView.snp.bottom).offset(8)
            make.height.equalTo(25)
            make.width.equalTo(120)
        }
        
        loadWeightView.addSubview(loadWeightLabel)
        loadWeightLabel.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        loadWeightView.addSubview(loadWeightIconImageView)
        loadWeightIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(loadWeightLabel.snp.left).offset(-10)
        }
        
        addSubview(shipperInformationView)
        shipperInformationView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-15)
            make.right.equalToSuperview().offset(-15)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(15)
        }
        
        shipperInformationView.addSubview(shipperWordLabel)
        shipperWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        shipperInformationView.addSubview(shipperLabel)
        shipperLabel.snp.makeConstraints { make in
            make.top.equalTo(shipperWordLabel.snp.bottom).offset(5)
            make.left.equalToSuperview()
        }
        
        shipperInformationView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(17)
        }
        
//        shipperInformationView.addSubview(callShipperButton)
//        callShipperButton.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview()
//            make.height.equalTo(40)
//            make.width.equalTo(120)
//        }
    }
}
