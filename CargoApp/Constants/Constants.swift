//
//  Constants.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit
import Hex

final class Constants {
    
    static let shared = Constants()
    
    let mainColor = UIColor(hex: "#EE815F")
    let textFieldTextFont = UIFont(name: Fonts.RobotoRegular.rawValue, size: 18)
    
    let labelAboveTextFieldFont = UIFont(name: Fonts.RobotoMedium.rawValue, size: 20)
    let textFieldsBorderColor = UIColor.lightGray.cgColor
    
    private init() {}
}
