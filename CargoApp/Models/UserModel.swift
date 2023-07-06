//
//  UserModel.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

struct UserModel: Codable {
    let firstName: String
    let lastName: String
    let dotNumber: Int
    let isShipper: Bool
    let ordersCount: Int
    let memberSince: String
}
