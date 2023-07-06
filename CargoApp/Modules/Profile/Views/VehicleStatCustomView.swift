//
//  VehicleStatCustomView.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 06.07.23.
//

import UIKit

final class VehicleStatCustomView: UIView {
    
    lazy var vehicleStatWordLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        view.textColor = .systemGray
        return view
    }()
    
    lazy var vehicleStatLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addSubview(vehicleStatWordLabel)
        vehicleStatWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        addSubview(vehicleStatLabel)
        vehicleStatLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(vehicleStatWordLabel.snp.bottom).offset(3)
        }
    }
    
}
