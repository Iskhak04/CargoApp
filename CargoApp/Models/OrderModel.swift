//
//  OrderModel.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 06.07.23.
//

import Foundation


struct OrderModel {
    let orderId: Int
    let pickUpDate: String
    let pickUpLocation: String
    let dropOffLocation: String
    let distance: Int
    let vehicleType: Vehicle
    let productWeight: Int
    let ratePerMile: Double
    let spaceNeeded: SpaceNeeded
    let packagingType: PackagingType
    let product: String
    let price: Int
}
