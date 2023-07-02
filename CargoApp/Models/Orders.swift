//
//  Orders.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

struct Orders: Codable {
    let orders: [OrderModel]
}

struct OrderModel: Codable {
    let orderDropOffCity: String
    let orderDropOffPostCode: Int
    let orderDropOffState: String
    let orderPickUpCity: String
    let orderPickUpDate: String
    let orderPickUpPostCode: String
    let orderPickUpState: String
    let orderPostDate: String
    let orderPostTime: String
    let orderPrice: Int
    let productWeight: Int
    let routeDistance: Int
    let vehicleType: String
}
