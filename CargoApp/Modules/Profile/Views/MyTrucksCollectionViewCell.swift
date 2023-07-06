//
//  MyTrucksCollectionViewCell.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 06.07.23.
//

import UIKit

final class MyTrucksCollectionViewCell: UICollectionViewCell {
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var vehicleNameLabel: UILabel = {
        let view = UILabel()
        view.text = "Toyota Wish"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 25)
        return view
    }()
    
    lazy var vehicleIdLabel: UILabel = {
        let view = UILabel()
        view.text = "#1"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 25)
        return view
    }()
    
    lazy var vehicleNameView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Name"
        view.vehicleStatLabel.text = "Riefer"
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var vehicleTypeView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Type"
        view.vehicleStatLabel.text = "Truck"
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var vehicleWeightView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Weight (lbs)"
        view.vehicleStatLabel.text = "10.000"
        view.backgroundColor = .cyan
        return view
    }()
    
    lazy var vehicleMaxLoadWeightView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Max weight (lbs)"
        view.vehicleStatLabel.text = "25.000"
        return view
    }()
    
    lazy var vehicleHeightView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Height (ft)"
        view.vehicleStatLabel.text = "15"
        return view
    }()
    
    lazy var vehicleLengthView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Length (ft)"
        view.vehicleStatLabel.text = "30"
        return view
    }()
    
    lazy var vehicleWidthView: VehicleStatCustomView = {
        let view = VehicleStatCustomView()
        view.vehicleStatWordLabel.text = "Width (ft)"
        view.vehicleStatLabel.text = "9"
        return view
    }()
    
   
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-5)
        }
        bgView.backgroundColor = .yellow
        
        bgView.addSubview(vehicleNameLabel)
        vehicleNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        bgView.addSubview(vehicleIdLabel)
        vehicleIdLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        bgView.addSubview(vehicleTypeView)
        vehicleTypeView.snp.makeConstraints { make in
            make.top.equalTo(vehicleNameLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
        
        bgView.addSubview(vehicleWeightView)
        vehicleWeightView.snp.makeConstraints { make in
            make.top.equalTo(vehicleNameLabel.snp.bottom).offset(10)
            make.left.equalTo(vehicleTypeView.snp.right).offset(0)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
        
        bgView.addSubview(vehicleMaxLoadWeightView)
        vehicleMaxLoadWeightView.snp.makeConstraints { make in
            make.top.equalTo(vehicleNameLabel.snp.bottom).offset(10)
            make.left.equalTo(vehicleWeightView.snp.right).offset(0)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
        
        bgView.addSubview(vehicleHeightView)
        vehicleHeightView.snp.makeConstraints { make in
            make.top.equalTo(vehicleTypeView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
        
        bgView.addSubview(vehicleWidthView)
        vehicleWidthView.snp.makeConstraints { make in
            make.top.equalTo(vehicleTypeView.snp.bottom).offset(30)
            make.left.equalTo(vehicleHeightView.snp.right).offset(0)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
        
        bgView.addSubview(vehicleLengthView)
        vehicleLengthView.snp.makeConstraints { make in
            make.top.equalTo(vehicleTypeView.snp.bottom).offset(30)
            make.left.equalTo(vehicleWidthView.snp.right).offset(0)
            make.height.equalTo(44)
            make.width.equalTo(123)
        }
    }
}
