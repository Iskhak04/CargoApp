//
//  UserTypeSelectionViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 02.07.23.
//

import UIKit

final class UserTypeSelectionViewController: UIViewController {
    
    private lazy var pagesCollectionVeiw: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.register(UserTypeSelectionCell.self, forCellWithReuseIdentifier: "UserTypeSelectionCell")
        view.register(EnterPhoneCell.self, forCellWithReuseIdentifier: "EnterPhoneCell")
        view.register(ConfirmPhoneCell.self, forCellWithReuseIdentifier: "ConfirmPhoneCell")
        view.register(EnterEmailCell.self, forCellWithReuseIdentifier: "EnterEmailCell")
        view.register(ConfirmEmailCell.self, forCellWithReuseIdentifier: "ConfirmEmailCell")
        view.register(PersonDetailsCell.self, forCellWithReuseIdentifier: "PersonDetailsCell")
        view.backgroundColor = .gray
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var shipperButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 20
        configuration.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large))
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .label
        configuration.attributedTitle = try! AttributedString( NSAttributedString(string: "I'm a shipper", attributes: [.font: UIFont(name: Fonts.RobotoRegular.rawValue, size: 28)!, .foregroundColor: UIColor.white,]), including: AttributeScopes.UIKitAttributes.self)
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .label
        button.addTarget(self, action: #selector(shipperButtonClicked), for: .touchUpInside)
        return button
    }()
    
    lazy var carrierButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.imagePadding = 20
        configuration.image = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large))
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = .label
        configuration.attributedTitle = try! AttributedString( NSAttributedString(string: "I'm a carrier", attributes: [.font: UIFont(name: Fonts.RobotoRegular.rawValue, size: 28)!, .foregroundColor: UIColor.white,]), including: AttributeScopes.UIKitAttributes.self)
        let button = UIButton(configuration: configuration)
        button.backgroundColor = .label
        button.addTarget(self, action: #selector(carrierButtonClicked), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagesCollectionVeiw.contentInsetAdjustmentBehavior = .never
        navigationController?.navigationBar.tintColor = UIColor.label;
        view.backgroundColor = .systemBackground
        layout()
    }
    
    @objc private func carrierButtonClicked() {
        pagesCollectionVeiw.scrollToItem(at: IndexPath(row: 1, section: 0), at: [], animated: true)
    }
    
    @objc private func shipperButtonClicked() {
        pagesCollectionVeiw.scrollToItem(at: IndexPath(row: 1, section: 0), at: [], animated: true)
    }
    
    private func layout() {
        
        view.addSubview(pagesCollectionVeiw)
        pagesCollectionVeiw.snp.makeConstraints { make in
            make.top.bottom.right.left.equalToSuperview()
            make.height.width.equalToSuperview()
        }
    }
}

extension UserTypeSelectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var returnCell = UICollectionViewCell()
        
        switch indexPath.row {
        case 0:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "UserTypeSelectionCell", for: indexPath) as! UserTypeSelectionCell
            cell.carrierButton = self.carrierButton
            cell.shipperButton = self.shipperButton
            print(indexPath)
            returnCell = cell
        case 1:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "EnterPhoneCell", for: indexPath) as! EnterPhoneCell
            cell.backgroundColor = .cyan
            print(indexPath.row)
            returnCell = cell
        case 2:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "ConfirmPhoneCell", for: indexPath) as! ConfirmPhoneCell
            cell.backgroundColor = .brown
            print(indexPath)
            returnCell = cell
        case 3:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "EnterEmailCell", for: indexPath) as! EnterEmailCell
            cell.backgroundColor = .red
            print(indexPath)
            returnCell = cell
        case 4:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "ConfirmEmailCell", for: indexPath) as! ConfirmEmailCell
            cell.backgroundColor = .blue
            print(indexPath)
            returnCell = cell
        case 5:
            let cell = pagesCollectionVeiw.dequeueReusableCell(withReuseIdentifier: "PersonDetailsCell", for: indexPath) as! PersonDetailsCell
            cell.backgroundColor = .green
            print(indexPath)
            returnCell = cell
        default:
            ()
        }
        
        return returnCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
