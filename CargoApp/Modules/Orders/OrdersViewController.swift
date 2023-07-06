//
//  OrdersViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    var presenter: OrdersPresenterProtocol?
    
    var orders: [OrderModel] = [OrderModel(orderId: 1, pickUpDate: "8 Jul", pickUpLocation: "Austin", dropOffLocation: "Los-Angeles", distance: 945, vehicleType: .Reefer, productWeight: 20000, ratePerMile: 2.1, spaceNeeded: .FullTruck, packagingType: .Box, product: "Dishes", price: 1490), OrderModel(orderId: 2, pickUpDate: "12 Aug", pickUpLocation: "Miami", dropOffLocation: "Dallas", distance: 1295, vehicleType: .Flatbed, productWeight: 40000, ratePerMile: 2.8, spaceNeeded: .FullTruck, packagingType: .Pallet, product: "Dry Food", price: 1800), OrderModel(orderId: 3, pickUpDate: "7 Jul", pickUpLocation: "Houston", dropOffLocation: "New-York", distance: 1958, vehicleType: .Reefer, productWeight: 40000, ratePerMile: 2.9, spaceNeeded: .FullTruck, packagingType: .Box, product: "Fruits", price: 1948), OrderModel(orderId: 4, pickUpDate: "29 Jul", pickUpLocation: "Phoenix", dropOffLocation: "Portland", distance: 858, vehicleType: .Flatbed, productWeight: 10000, ratePerMile: 2.5, spaceNeeded: .Partial, packagingType: .Box, product: "Souvenirs", price: 1300)]
    
    var filteredOrders: [OrderModel] = []
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.delegate = self
        return view
    }()
    
    private lazy var ordersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OrderCell.self, forCellWithReuseIdentifier: "OrderCell")
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var placeOrderButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large)), for: .normal)
        view.backgroundColor = .label
        view.tintColor = .systemBackground
        view.addTarget(self, action: #selector(placeOrderButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationItem.title = "Orders"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchOrders()
        filteredOrders = orders
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search by ID"
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        navigationItem.titleView = searchBar
        navigationItem.title = "Orders"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = .systemBackground
        layout()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("hello")
        ordersCollectionView.reloadData()
    }
    
    @objc private func placeOrderButtonClicked() {
        navigationController?.dismiss(animated: true)
        navigationController?.pushViewController(PlaceOrderViewController(), animated: true)
    }
    
    private func layout() {
        view.addSubview(ordersCollectionView)
        ordersCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
        }
        
        view.addSubview(placeOrderButton)
        placeOrderButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-100)
            make.right.equalToSuperview().offset(-30)
            make.height.width.equalTo(50)
        }
    }
}

extension OrdersViewController: UISearchBarDelegate {
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredOrders = searchText.isEmpty ? orders : orders.filter({ order in
            return String(order.orderId).range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        })
        
        ordersCollectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        filteredOrders = orders
        ordersCollectionView.reloadData()
        searchBar.resignFirstResponder()
    }
}

extension OrdersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ordersCollectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        
        cell.backgroundColor = .systemBackground
        cell.layer.shadowColor = UIColor.label.cgColor
        cell.layer.shadowRadius = 7
        cell.layer.shouldRasterize = true
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.layer.cornerRadius = 10
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        cell.pickUpDateLabel.text = "Pick Up - \(filteredOrders[indexPath.row].pickUpDate)"
        cell.pickUpAddressLabel.text = filteredOrders[indexPath.row].pickUpLocation
        cell.dropOffAddressLabel.text = filteredOrders[indexPath.row].dropOffLocation
        cell.distanceLabel.text = "\(filteredOrders[indexPath.row].distance) mi"
        cell.vehicleTypeLabel.text = filteredOrders[indexPath.row].vehicleType.rawValue
        cell.loadWeightLabel.text = "\(filteredOrders[indexPath.row].productWeight) lbs"
        cell.priceLabel.text = "$\(filteredOrders[indexPath.row].price)"
        cell.orderIdLabel.text = "#\(filteredOrders[indexPath.row].orderId)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToDetailedOrder(order: filteredOrders[indexPath.row])
    }

}

extension OrdersViewController: OrdersViewProtocol {
    
}
