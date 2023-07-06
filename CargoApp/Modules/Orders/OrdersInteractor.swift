//
//  OrdersInteractor.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import FirebaseDatabase

final class OrdersInteractor {
    
    var presenter: OrdersPresenterProtocol?
    var ref = Database.database().reference()
    
}

extension OrdersInteractor: OrdersInteractorProtocol {
    
    func fetchOrders() {
        
//        let child = ref.child("orders")
//        
//        child.observeSingleEvent(of: .value) { snapshot  in
//            do {
//                let object = try snapshot.data(as: OrderModel.self)
//                print("hello")
//            } catch let error{
//                print("world \(error.localizedDescription)")
//            }
//            
//        }
        
    }
    
}
