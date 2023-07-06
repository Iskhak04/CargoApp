//
//  DetailedOrderViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 01.07.23.
//

import UIKit
import MapKit


final class DetailedOrderViewController: UIViewController {
    
    var presenter: DetailedOrderPresenterProtocol?
    
    var pickUpLocation: CLLocation = CLLocation(latitude: 33.515915842143556, longitude: -86.80900570276167)
    
    var dropOffLocation: CLLocation = CLLocation(latitude: 31.217031101244036, longitude: -98.39342797721083)
    
    var distanceInMiles: Double = 0
    var isMapFullScreen: Bool = false
    
    //Birmingham, Al
    //33.515915842143556, -86.80900570276167
    
    //Lometa, TX
    //31.217031101244036, -98.39342797721083
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()

    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        return view
    }()
    
    private lazy var fullScreenButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "arrow.up.and.down.and.arrow.left.and.right", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)), for: .normal)
        view.tintColor = .label
        view.addTarget(self, action: #selector(fullScreenButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var pickUpDateLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick Up - ASAP"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 17)
        return view
    }()
    
    private lazy var priceLabel: UILabel = {
        let view = UILabel()
        view.text = "$1290"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 22)
        view.textColor = .systemGreen
        return view
    }()
    
    private lazy var pickUpView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var pickUpIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemGreen
        return view
    }()
    
    private lazy var pickUpWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick up"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 16)
        view.textColor = .gray
        return view
    }()
    
    private lazy var pickUpAddressLabel: UILabel = {
        let view = UILabel()
        view.text = "Birmingham, AL 35203"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 19)
        return view
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var dropOffView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var dropOffIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemRed
        return view
    }()
    
    private lazy var dropOffWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Drop off"
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 16)
        view.textColor = .gray
        return view
    }()
    
    private lazy var dropOffAddressLabel: UILabel = {
        let view = UILabel()
        view.text = "Lometa, TX 76853"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 19)
        return view
    }()
    
    private lazy var horizontalLine1View: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var detailsLabel: UILabel = {
        let view = UILabel()
        view.text = "Product Details"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 22)
        return view
    }()
    
    private lazy var vehicleTypeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var vehicleTypeWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Vehicle"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var vehicleTypeLabel: UILabel = {
        let view = UILabel()
        view.text = "Flatbed"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var productView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var productWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Product"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var productLabel: UILabel = {
        let view = UILabel()
        view.text = "Dry Food"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var packagingTypeView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var packagingTypeWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Packaging type"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var packagingTypeLabel: UILabel = {
        let view = UILabel()
        view.text = "Pallets"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var weightView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var weightWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Weight"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var weightLabel: UILabel = {
        let view = UILabel()
        view.text = "42.000 lbs"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var horizontalLine2View: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var loadDetailsLabel: UILabel = {
        let view = UILabel()
        view.text = "Load Details"
        view.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 22)
        return view
    }()
    
    private lazy var distanceView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var distanceWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Distance"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var distanceLabel: UILabel = {
        let view = UILabel()
        view.text = "197 mi"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var ratePerMileView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var ratePerMileWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Rate Per Mile"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var ratePerMileLabel: UILabel = {
        let view = UILabel()
        view.text = "$2.30 / mi"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var loadIdView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var loadIdWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Load ID"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var loadIdLabel: UILabel = {
        let view = UILabel()
        view.text = "#12345"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var spaceNeededView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var spaceNeededWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Space needed"
        view.textColor = .gray
        view.font = UIFont(name: Fonts.RobotoRegular.rawValue, size: 17)
        return view
    }()
    
    private lazy var spaceNeededLabel: UILabel = {
        let view = UILabel()
        view.text = "Full truck"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 18)
        return view
    }()
    
    private lazy var horizontalLine3View: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private lazy var shipperWordLabel: UILabel = {
        let view = UILabel()
        view.text = "DIRECT SHIPPER - INDIVIDUAL"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 17)
        view.textColor = .gray
        return view
    }()
    
    private lazy var shipperNameButton: UIButton = {
        let view = UIButton()
        view.setTitle("Chrissy Dorsey", for: .normal)
        view.setTitleColor(UIColor.systemOrange, for: .normal)
        view.titleLabel!.font = UIFont(name: Fonts.RobotoBold.rawValue, size: 22)!
        view.addTarget(self, action: #selector(shipperNameButtonClicked), for: .touchUpInside)
        return view
    }()
    
    private lazy var starImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15, weight: .medium, scale: .large))
        view.tintColor = .systemYellow
        return view
    }()
    
    private lazy var avgRatingLabel: UILabel = {
        let view = UILabel()
        view.text = "3.5"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 17)
        return view
    }()
    
    private lazy var moreInfoLabel: UILabel = {
        let view = UILabel()
        view.text = "(35 ratings / 18 loads)"
        view.font = UIFont(name: Fonts.RobotoMedium.rawValue, size: 17)
        view.textColor = .gray
        return view
    }()
    
    private lazy var callShipperButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "phone.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .large)), for: .normal)
        view.tintColor = .white
        view.backgroundColor = .systemGreen
        view.addTarget(self, action: #selector(callShipperButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 35
        return view
    }()
    
    private lazy var takeOrderButton: UIButton = {
        let view = UIButton()
        view.setTitle("Take Order", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(takeOrderButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "Load Details"
        navigationController?.navigationBar.tintColor = .label
        layout()
        configureMap()
    }
    
    @objc private func takeOrderButtonClicked() {
        
    }
    
    @objc private func fullScreenButtonClicked() {
        
        if isMapFullScreen {
            
            mapView.snp.updateConstraints { make in
                make.height.equalTo(300)
            }

            fullScreenButton.snp.remakeConstraints { make in
                make.bottom.equalToSuperview().offset(-25)
                make.right.equalToSuperview().offset(-8)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            isMapFullScreen = !isMapFullScreen
        } else {
            
            mapView.snp.updateConstraints { make in
                make.height.equalTo(view.frame.height)
            }
            fullScreenButton.snp.remakeConstraints { make in
                make.bottom.equalTo(view.snp.bottom).offset(-40)
                make.right.equalTo(view.snp.right).offset(-15)
                make.height.equalTo(40)
                make.width.equalTo(40)
            }
            isMapFullScreen = !isMapFullScreen
        }
        
    }
    
    @objc private func callShipperButtonClicked() {
        guard let number = URL(string: "tel://996704728104") else { return }
        UIApplication.shared.open(number)
        
    }
    
    @objc private func shipperNameButtonClicked() {
        //go to shipper's profile
        
    }
    
    private func configureMap() {
        //calculating distance betwee pick up and drop off locations
        distanceInMiles = calculateDistance(firstLocation: pickUpLocation, secondLocation: dropOffLocation)
        
        //adding pin (annotatin) for pick up location
        addAnnotation(location: pickUpLocation, title: "Pick Up")
        
        //adding pin (annotatin) for drop off location
        addAnnotation(location: dropOffLocation, title: "Drop Off")
        
        //drawing a route between pick up and drop off locations
        drawRoute(pickUpLocation: pickUpLocation, dropOffLocatin: dropOffLocation)
        
        //zooming in to the center between pick up and drop off locations
        zoomToRegion(firstLocation: pickUpLocation, secondLocation: dropOffLocation)
    }
    
    private func calculateDistance(firstLocation: CLLocation, secondLocation: CLLocation) -> Double {
        return firstLocation.distance(from: secondLocation) * 0.000621371
    }
    
    private func addAnnotation(location: CLLocation, title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapView.addAnnotation(point)
    }
    
    private func layout() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
            make.width.equalTo(scrollView.frame.width)
            make.height.equalTo(scrollView.snp.height).offset(200)
        }

        scrollView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(300)
            make.width.equalToSuperview()
        }
        
        mapView.addSubview(fullScreenButton)
        fullScreenButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25)
            make.right.equalToSuperview().offset(-8)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        scrollView.addSubview(pickUpDateLabel)
        pickUpDateLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.right.equalTo(view.snp.right).offset(-20)
            make.top.equalTo(mapView.snp.bottom).offset(20)
        }
        
        scrollView.addSubview(pickUpView)
        pickUpView.snp.makeConstraints { make in
            make.top.equalTo(pickUpDateLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        
        pickUpView.addSubview(pickUpIconImageView)
        pickUpIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        
        pickUpView.addSubview(pickUpWordLabel)
        pickUpWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        pickUpView.addSubview(pickUpAddressLabel)
        pickUpAddressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        scrollView.addSubview(dropOffView)
        dropOffView.snp.makeConstraints { make in
            make.top.equalTo(pickUpView.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(40)
            make.width.equalTo(220)
        }
        
        dropOffView.addSubview(dropOffIconImageView)
        dropOffIconImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(5)
        }
        
        dropOffView.addSubview(dropOffWordLabel)
        dropOffWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(dropOffIconImageView.snp.right).offset(5)
        }
        
        dropOffView.addSubview(dropOffAddressLabel)
        dropOffAddressLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.equalTo(pickUpIconImageView.snp.right).offset(5)
        }
        
        scrollView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.top.equalTo(pickUpView.snp.bottom).offset(0)
            make.bottom.equalTo(dropOffView.snp.top).offset(0)
            make.width.equalTo(2)
            make.left.equalToSuperview().offset(43)
        }
        
        scrollView.addSubview(horizontalLine1View)
        horizontalLine1View.snp.makeConstraints { make in
            make.top.equalTo(dropOffView.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        scrollView.addSubview(detailsLabel)
        detailsLabel.snp.makeConstraints { make in
            make.top.equalTo(dropOffView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }

        scrollView.addSubview(vehicleTypeView)
        vehicleTypeView.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        vehicleTypeView.addSubview(vehicleTypeWordLabel)
        vehicleTypeWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        vehicleTypeView.addSubview(vehicleTypeLabel)
        vehicleTypeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(vehicleTypeWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(productView)
        productView.snp.makeConstraints { make in
            make.top.equalTo(detailsLabel.snp.bottom).offset(20)
            make.left.equalTo(vehicleTypeView.snp.right).offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        productView.addSubview(productWordLabel)
        productWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        productView.addSubview(productLabel)
        productLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(productWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(packagingTypeView)
        packagingTypeView.snp.makeConstraints { make in
            make.top.equalTo(vehicleTypeView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        packagingTypeView.addSubview(packagingTypeWordLabel)
        packagingTypeWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        packagingTypeView.addSubview(packagingTypeLabel)
        packagingTypeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(packagingTypeWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(weightView)
        weightView.snp.makeConstraints { make in
            make.top.equalTo(productView.snp.bottom).offset(20)
            make.left.equalTo(packagingTypeView.snp.right).offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        weightView.addSubview(weightWordLabel)
        weightWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        weightView.addSubview(weightLabel)
        weightLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(weightWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(horizontalLine2View)
        horizontalLine2View.snp.makeConstraints { make in
            make.top.equalTo(packagingTypeView.snp.bottom).offset(20)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        scrollView.addSubview(loadDetailsLabel)
        loadDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(packagingTypeView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(distanceView)
        distanceView.snp.makeConstraints { make in
            make.top.equalTo(loadDetailsLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        distanceView.addSubview(distanceWordLabel)
        distanceWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        distanceView.addSubview(distanceLabel)
        distanceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(distanceWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(ratePerMileView)
        ratePerMileView.snp.makeConstraints { make in
            make.top.equalTo(loadDetailsLabel.snp.bottom).offset(20)
            make.left.equalTo(distanceView.snp.right).offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        ratePerMileView.addSubview(ratePerMileWordLabel)
        ratePerMileWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        ratePerMileView.addSubview(ratePerMileLabel)
        ratePerMileLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(ratePerMileWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(loadIdView)
        loadIdView.snp.makeConstraints { make in
            make.top.equalTo(distanceView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        loadIdView.addSubview(loadIdWordLabel)
        loadIdWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        loadIdView.addSubview(loadIdLabel)
        loadIdLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(loadIdWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(spaceNeededView)
        spaceNeededView.snp.makeConstraints { make in
            make.top.equalTo(ratePerMileView.snp.bottom).offset(20)
            make.left.equalTo(loadIdView.snp.right).offset(20)
            make.width.equalTo((view.frame.width - 40) / 2 - 10)
            make.height.equalTo(60)
        }
        
        spaceNeededView.addSubview(spaceNeededWordLabel)
        spaceNeededWordLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
        }
        
        spaceNeededView.addSubview(spaceNeededLabel)
        spaceNeededLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.top.equalTo(spaceNeededWordLabel.snp.bottom).offset(5)
        }
        
        scrollView.addSubview(horizontalLine3View)
        horizontalLine3View.snp.makeConstraints { make in
            make.top.equalTo(spaceNeededView.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        scrollView.addSubview(shipperWordLabel)
        shipperWordLabel.snp.makeConstraints { make in
            make.top.equalTo(loadIdView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(shipperNameButton)
        shipperNameButton.snp.makeConstraints { make in
            make.top.equalTo(shipperWordLabel.snp.bottom).offset(0)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(starImageView)
        starImageView.snp.makeConstraints { make in
            make.top.equalTo(shipperNameButton.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(avgRatingLabel)
        avgRatingLabel.snp.makeConstraints { make in
            make.top.equalTo(shipperNameButton.snp.bottom).offset(5)
            make.left.equalTo(starImageView.snp.right).offset(5)
        }
        
        scrollView.addSubview(moreInfoLabel)
        moreInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(shipperNameButton.snp.bottom).offset(5)
            make.left.equalTo(avgRatingLabel.snp.right).offset(5)
        }
        
//        scrollView.addSubview(callShipperButton)
//        callShipperButton.snp.makeConstraints { make in
//            make.top.equalTo(spaceNeededView.snp.bottom).offset(35)
//            make.right.equalTo(view.snp.right).offset(-20)
//            make.height.equalTo(70)
//            make.width.equalTo(70)
//        }
        
        scrollView.addSubview(takeOrderButton)
        takeOrderButton.snp.makeConstraints { make in
            make.top.equalTo(moreInfoLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(200)
        }
    }
    
    private func zoomToRegion(firstLocation: CLLocation, secondLocation: CLLocation) {
        let centerLatitude = (firstLocation.coordinate.latitude + secondLocation.coordinate.latitude) / 2
        let centerLongitude = (firstLocation.coordinate.longitude + secondLocation.coordinate.longitude) / 2
        let centerLocatoin = CLLocation(latitude: centerLatitude, longitude: centerLongitude)
        
        let viewRegion = MKCoordinateRegion(center: centerLocatoin.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        self.mapView.setRegion(viewRegion, animated: true)
        
    }
    
    private func drawRoute(pickUpLocation: CLLocation, dropOffLocatin: CLLocation) {
        
        let sourcePlacemark = MKPlacemark(coordinate: pickUpLocation.coordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: dropOffLocatin.coordinate, addressDictionary: nil)
        
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
        let directionRequest = MKDirections.Request()
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        // Calculate the direction
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                
                return
            }
            
            let route = response.routes[0]
            
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
        }
    }
    
    private func addPolyline(coordinates: [CLLocation]) {
        
        let polylineCords = coordinates.map { location -> CLLocationCoordinate2D in
            return location.coordinate
        }
        
        let polyline = MKPolyline.init(coordinates: polylineCords, count: polylineCords.count)
        self.mapView.addOverlay(polyline, level: .aboveRoads)
    }
}

extension DetailedOrderViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            //assign annotation
            annotationView?.annotation = annotation
        }
        
        switch annotation.title {
        case "Pick Up":
            let image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
            
            annotationView?.backgroundColor = .white
            annotationView?.layer.cornerRadius = 19
            annotationView?.setPin(image: image!, with: .systemGreen)
        case "Drop Off":
            let image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
            
            annotationView?.backgroundColor = .white
            annotationView?.layer.cornerRadius = 19
            annotationView?.setPin(image: image!, with: .systemRed)
        default:
            ()
        }
        
        return annotationView
    }
    
    //Render polyline on map
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.red
            renderer.lineWidth = 3
            return renderer
        }

        return MKOverlayRenderer()
    }
}

extension DetailedOrderViewController: DetailedOrderViewProtocol {
    
}

extension MKAnnotationView {

    public func setPin(image: UIImage = UIImage(systemName: "mappin.circle.fill")!,
                       with color : UIColor? = nil) {
        let view: UIImageView
        
        if let color = color {
            // set tint color if specified
            view = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
            view.tintColor = color
        } else {
            // keep original image colors if unspecified
            view = UIImageView(image: image)
        }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        guard let graphicsContext = UIGraphicsGetCurrentContext() else { return }
        view.layer.render(in: graphicsContext)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.image = image
    }
}








