//
//  NetworkLayer.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 03.07.23.
//

import Foundation
import CoreLocation
import FirebaseStorage
import UIKit

final class NetworkLayer {
    
    static let shared = NetworkLayer()
    
    
    
    func getDirection(profile: String, firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) {
        let url = "https://api.mapbox.com/directions/v5/mapbox/\(profile)/\(firstCoordinate.latitude),\(firstCoordinate.longitude);\(secondCoordinate.latitude),\(secondCoordinate.longitude)"
    }
    
    func uploadImage(_ image: UIImage, at reference: StorageReference, completion: @escaping (URL?) -> Void) {
        // 1
        guard let imageData = image.jpegData(compressionQuality: 0.1) else {
            return completion(nil)
        }

        // 2
        reference.putData(imageData, metadata: nil, completion: { (metadata, error) in
            // 3
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }

            // 4
            reference.downloadURL(completion: { (url, error) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    return completion(nil)
                }
                completion(url)
            })
        })
    }
    
    private init() {}
}
