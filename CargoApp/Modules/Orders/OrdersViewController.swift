//
//  OrdersViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    var presenter: OrdersPresenterProtocol?
    
    private lazy var ordersTableView: UITableView = {
        let view = UITableView()
        view.register(OrderCell.self, forCellReuseIdentifier: "OrderCell")
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        layout()
    }
    
    private func layout() {
        view.addSubview(ordersTableView)
        ordersTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
}

extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 2
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        presenter?.goToDetailedOrder()

    }
    
    
}

extension OrdersViewController: OrdersViewProtocol {
    
}
