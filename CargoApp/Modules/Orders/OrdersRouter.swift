//
//  OrdersRouter.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrdersRouter {
    
    weak var viewController: UIViewController?
    
}

extension OrdersRouter: OrdersRouterProtocol {

    func goToDetailedOrder(order: OrderModel) {
        //go to detailed order page

        viewController?.navigationController?.dismiss(animated: true)
        viewController?.navigationController?.pushViewController(DetailedOrderModuleBuilder.build(order: order), animated: true)
    }
    
}
