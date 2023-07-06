//
//  OrdersViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 30.06.23.
//

import UIKit

final class OrdersViewController: UIViewController {
    
    var presenter: OrdersPresenterProtocol?
    
    private lazy var ordersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OrderCell.self, forCellWithReuseIdentifier: "OrderCell")
        view.dataSource = self
        view.delegate = self
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchOrders()
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
    
    private func layout() {
        view.addSubview(ordersCollectionView)
        ordersCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
        }
    }
}

extension OrdersViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = ordersCollectionView.dequeueReusableCell(withReuseIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.backgroundColor = .systemBackground
        //cell.layer.shadowPath = UIBezierPath(rect: cell.bounds).cgPath
        cell.layer.shadowColor = UIColor.label.cgColor
        cell.layer.shadowRadius = 7
        cell.layer.shouldRasterize = true
        cell.layer.shadowOpacity = 0.7
        cell.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        cell.layer.cornerRadius = 10
        cell.layer.rasterizationScale = UIScreen.main.scale
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 40, height: 240)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.goToDetailedOrder()
    }

}

extension OrdersViewController: OrdersViewProtocol {
    
}
