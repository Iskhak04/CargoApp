//
//  OrderModel.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 06.07.23.
//

import Foundation


struct OrderModel: Codable {
    let author: String
    let pickUpDate: String
    let pickUpLocationName: String
    let dropOffLocationName: String
    let dropOffLongitude: Double
    let dropOffLatitude: Double
    let pickUpLongitude: Double
    let pickUpLatitude: Double
    let distance: Double
    let vehicleType: String
    let weight: Int
    let ratePerMile: Double
    let spaceNeeded: String
    let packagingType: String
    let productType: String
    let price: Int
    
}
