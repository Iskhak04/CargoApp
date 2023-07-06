//
//  NetworkLayer.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 03.07.23.
//

import Foundation
import CoreLocation

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    
    
    func getDirection(profile: String, firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) {
        let url = "https://api.mapbox.com/directions/v5/mapbox/\(profile)/\(firstCoordinate.latitude),\(firstCoordinate.longitude);\(secondCoordinate.latitude),\(secondCoordinate.longitude)"
    }
    
    private init() {}
}
