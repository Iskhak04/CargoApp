//
//  PlaceOrderViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 07.07.23.
//

import UIKit
import MapKit
import KDCalendar
import FirebaseAuth
import FirebaseDatabase

final class PlaceOrderViewController: UIViewController {
        
    var pickUpLatitude: Double?
    var pickUpLongitude: Double?
    var pickUpLocality: String?
    var pickUpAdministrativeArea: String?
    var pickUpName: String?
    
    var dropOffName: String?
    
    var pickUpDate: String?
    
    var dropOffLatitude: Double?
    var dropOffLongitude: Double?
    var dropOffLocality: String?
    var dropOffAdministrativeArea: String?
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        
        return view
    }()


    private lazy var calendarView: CalendarView = {
        let view = CalendarView()
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .blue
        view.style.cellColorDefault = .cyan
        view.style.cellTextColorDefault = .white
        return view
    }()
    
    private lazy var pickUpLocationWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick up location"
        return view
    }()
    
    private lazy var pickUpIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemGreen
        return view
    }()
    
    private lazy var choosePickUpLocationButton: UIButton = {
        let view = UIButton()
        view.setTitle("Choose", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(choosePickUpLocationButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var pickUpLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "No pick up location"
        return view
    }()
    
    private lazy var dropOffLocationWordLabel: UILabel = {
        let view = UILabel()
        view.text = "Drop off location"
        return view
    }()
    
    private lazy var dropOffIconImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        view.tintColor = .systemRed
        return view
    }()
    
    private lazy var chooseDropOffLocationButton: UIButton = {
        let view = UIButton()
        view.setTitle("Choose", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(chooseDropOffLocationButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var dropOffLocationLabel: UILabel = {
        let view = UILabel()
        view.text = "No drop off location"
        return view
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Product"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var productTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var productTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = productTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "e.g. Dishes, Food, Souvenirs.."
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var packagingTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Packaging type"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var packagingTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var packagingTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = packagingTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "e.g. Boxes, Pallets..."
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var weightTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Weight"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var weightTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var weightTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = weightTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "Weight in lbs"
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var spaceNeededTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Space needed"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var spaceNeededTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var spaceNeededTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = spaceNeededTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "e.g. Full truck, Partial..."
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()

    private lazy var vehicleTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Vehicle type"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var vehicleTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var vehicleTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = vehicleTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "e.g. Reefer, Flatbed, Van..."
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var priceTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Price ($)"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var priceTextFieldPaddingView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 15, height: 20)
        return view
    }()
    
    private lazy var priceTextField: UITextField = {
        let view = UITextField()
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.layer.borderColor = Constants.shared.textFieldsBorderColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 7
        view.leftView = priceTextFieldPaddingView
        view.leftViewMode = .always
        view.placeholder = "e.g. $1290.."
        view.defaultTextAttributes = [NSAttributedString.Key.font : Constants.shared.textFieldTextFont!]
        view.delegate = self
        return view
    }()
    
    private lazy var pickUpDateTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "Pick up date"
        view.font = Constants.shared.labelAboveTextFieldFont
        return view
    }()
    
    private lazy var choosePickUpDateButton: UIButton = {
        let view = UIButton()
        view.setTitle("Choose", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(choosePickUpDateButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var pickUpDateLabel: UILabel = {
        let view = UILabel()
        view.text = "No pick up date"
        return view
    }()
    
    private lazy var placeOrderButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add Order", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(placeOrderButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let today = Date()
        self.calendarView.setDisplayDate(today, animated: false)
        view.backgroundColor = .systemBackground
        navigationItem.title = "New Order"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        layout()
    }
    
    @objc private func placeOrderButtonClicked() {
        guard let pickUpDate = self.pickUpDate, let product = productTextField.text, let weight = weightTextField.text, let packaging = packagingTextField.text, let vehicle = vehicleTextField.text, let space = spaceNeededTextField.text, let price = priceTextField.text else { return }
        
        let databaseRef1 = Database.database().reference(withPath: "maxOrderId")
        
        
        let pickUp = CLLocation(latitude: pickUpLatitude!, longitude: pickUpLongitude!)
        let dropOff = CLLocation(latitude: dropOffLatitude!, longitude: dropOffLongitude!)
        let distance = calculateDistance(firstLocation: pickUp, secondLocation: dropOff)
        let ratePerMile = calculateRatePerMile(distance: distance, price: Int(price)!)
        
        print(pickUpLocality)

        print(pickUpAdministrativeArea)
        fetchUserData { [self] user in

            let newOrder: [String: Any] = ["pickUpDate": pickUpDate, "price": Int(price), "pickUpLatitude": pickUpLatitude, "pickUpLongitude": pickUpLongitude, "dropOffLatitude": dropOffLatitude, "dropOffLongitude": dropOffLongitude, "pickUpLocationName": "\(pickUpLocality!), \(pickUpName!)", "dropOffLocationName": "\(dropOffLocality!), \(dropOffName!)", "vehicleType": vehicle, "productType": product, "packagingType":packaging, "weight": weight, "spaceNeeded": space, "distance":distance, "ratePerMile": ratePerMile, "author":"\(user.firstName) \(user.lastName)"]

            let ref = Database.database().reference(withPath: "orders")

            ref.childByAutoId().setValue(newOrder)
        }
        
        
        

        
        
        
        
        
//        databaseRef1.observeSingleEvent(of: .value) { [self] snapshot in
//            print("snapshot")
//            print(snapshot.value)
//            let newOrderId = snapshot.value as! Int + 1
//            print(newOrderId)
//
//            let databaseRef = Database.database().reference(withPath: "orders/\(newOrderId)")
//
//            databaseRef.child("pickUpDate").setValue(pickUpDate)
//            databaseRef.child("price").setValue(Int(price))
//            databaseRef.child("pickUpLatitude").setValue(pickUpLatitude)
//            databaseRef.child("pickUpLongitude").setValue(pickUpLongitude)
//            databaseRef.child("dropOffLatitude").setValue(dropOffLatitude)
//            databaseRef.child("dropOffLongitude").setValue(dropOffLongitude)
//            databaseRef.child("pickUpLocationName").setValue("\(pickUpLocality!), \(pickUpAdministrativeArea!)")
//            databaseRef.child("dropOffLocationName").setValue("\(dropOffLocality!), \(dropOffAdministrativeArea!)")
//            databaseRef.child("vehicleType").setValue(vehicle)
//            databaseRef.child("productType").setValue(product)
//            databaseRef.child("packagingType").setValue(packaging)
//            databaseRef.child("weight").setValue(weight)
//            databaseRef.child("spaceNeeded").setValue(space)
//
//            let pickUp = CLLocation(latitude: pickUpLatitude!, longitude: pickUpLongitude!)
//            let dropOff = CLLocation(latitude: dropOffLatitude!, longitude: dropOffLongitude!)
//            let distance = calculateDistance(firstLocation: pickUp, secondLocation: dropOff)
//            let ratePerMile = calculateRatePerMile(distance: distance, price: Int(price)!)
//
//            databaseRef.child("distance").setValue(distance)
//            databaseRef.child("ratePerMile").setValue(ratePerMile)
//            fetchUserData { user in
//                databaseRef.child("author").setValue("\(user.firstName) \(user.lastName)")
//            }
//
//            print("success")
//
//        }
//        databaseRef1.getData { error, snapshot in
//            guard error == nil else { return }
//
//            let newOrderId = snapshot?.value as! Int + 1
//
//            databaseRef1.setValue(newOrderId)
//        }
        
        
        
        
    }
    
    private func fetchUserData(completion: @escaping (UserModel) -> Void) {
        let user = Auth.auth().currentUser
        
        let databaseRef = Database.database().reference(withPath: "users/\(user!.uid)")
        
        databaseRef.observe(.value) { snapshot in
            guard let jsonData = snapshot.value as? [String: Any] else { return }
            
            do {
                let userData = try JSONSerialization.data(withJSONObject: jsonData)
                
                let userRealData = try JSONDecoder().decode(UserModel.self, from: userData)
                print(userRealData.firstName)
                completion(userRealData)
            } catch {
                print("error fetching user data in profile vc:", error.localizedDescription)
            }
        }
    }
    
    private func calculateRatePerMile(distance: Double, price: Int) -> Double {
        return Double(price) / distance
    }
    
    private func calculateDistance(firstLocation: CLLocation, secondLocation: CLLocation) -> Double {
        return firstLocation.distance(from: secondLocation) * 0.000621371
    }
    
    @objc private func choosePickUpDateButtonClicked() {
        let calendarVC = CalendarViewController()
        calendarVC.callBack = { date in
            self.pickUpDate = self.getCurrentDate(date: date, date2: date)
            print(self.pickUpDate)
            self.pickUpDateLabel.text = self.pickUpDate
        }
        navigationController?.dismiss(animated: true)
        navigationController?.pushViewController(calendarVC, animated: true)
    }
    
    @objc private func choosePickUpLocationButtonClicked() {
//        present(MapViewController(), animated: true)
        navigationController?.dismiss(animated: true)
        let mapVC = MapViewController()
        mapVC.callBack = { location in
            self.pickUpLatitude = location.latitude
            self.pickUpLongitude = location.longitude
            let pickUpLocation = CLLocation(latitude: self.pickUpLatitude!, longitude: self.pickUpLongitude!)
            self.updatePlaceMark(to: pickUpLocation) { (locality, administrativeArea, name) in
                self.pickUpLocality = locality
                self.pickUpAdministrativeArea = administrativeArea
                self.pickUpName = name
                self.pickUpLocationLabel.text = "\(locality), \(administrativeArea), \(name)"
                
                
            }
        }
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    @objc private func chooseDropOffLocationButtonClicked() {
        navigationController?.dismiss(animated: true)
        let mapVC = MapViewController()
        mapVC.callBack = { location in
            self.dropOffLatitude = location.latitude
            self.dropOffLongitude = location.longitude
            let pickUpLocation = CLLocation(latitude: self.dropOffLatitude!, longitude: self.dropOffLongitude!)
            self.updatePlaceMark(to: pickUpLocation) { (locality, administrativeArea, name) in
                self.dropOffLocality = locality
                self.dropOffAdministrativeArea = administrativeArea
                self.dropOffName = name
                self.dropOffLocationLabel.text = "\(locality), \(administrativeArea), \(name)"
                
            }
        }
        navigationController?.pushViewController(mapVC, animated: true)
    }
    
    func updatePlaceMark(to clLocation: CLLocation, completion: @escaping ((String, String, String)) -> Void) {
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(clLocation) { placemarks, error in
            guard
                let placemark = placemarks?.first,
                let location = placemark.location
            else {
                print(error?.localizedDescription)
                return
            }
            
            print(placemark.administrativeArea)
            print(placemark.locality)
            print(placemark.name)
            
            //print(location.coordinate.latitude)
            completion((placemark.locality!, placemark.administrativeArea!, placemark.name!))
        }
    }
    
    func getCurrentDate(date: Date, date2: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        let yearString = dateFormatter.string(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "MMMM"
        let monthString = dateFormatter2.string(from: date2)
        
        return "\(yearString) \(monthString)"
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
            make.height.equalTo(scrollView.snp.height).offset(300)
        }
        
        scrollView.addSubview(pickUpLocationWordLabel)
        pickUpLocationWordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(pickUpIconImageView)
        pickUpIconImageView.snp.makeConstraints { make in
            make.top.equalTo(pickUpLocationWordLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(choosePickUpLocationButton)
        choosePickUpLocationButton.snp.makeConstraints { make in
            make.top.equalTo(pickUpLocationWordLabel.snp.bottom).offset(10)
            make.left.equalTo(pickUpIconImageView.snp.right).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        
        scrollView.addSubview(pickUpLocationLabel)
        pickUpLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(choosePickUpLocationButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(dropOffLocationWordLabel)
        dropOffLocationWordLabel.snp.makeConstraints { make in
            make.top.equalTo(pickUpLocationLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(dropOffIconImageView)
        dropOffIconImageView.snp.makeConstraints { make in
            make.top.equalTo(dropOffLocationWordLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(chooseDropOffLocationButton)
        chooseDropOffLocationButton.snp.makeConstraints { make in
            make.top.equalTo(dropOffLocationWordLabel.snp.bottom).offset(10)
            make.left.equalTo(dropOffIconImageView.snp.right).offset(20)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        
        scrollView.addSubview(dropOffLocationLabel)
        dropOffLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(chooseDropOffLocationButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(dropOffLocationLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(productTextField)
        productTextField.snp.makeConstraints { make in
            make.top.equalTo(productTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(packagingTitleLabel)
        packagingTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(productTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(packagingTextField)
        packagingTextField.snp.makeConstraints { make in
            make.top.equalTo(packagingTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(weightTitleLabel)
        weightTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(packagingTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(weightTextField)
        weightTextField.snp.makeConstraints { make in
            make.top.equalTo(weightTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(spaceNeededTitleLabel)
        spaceNeededTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(weightTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(spaceNeededTextField)
        spaceNeededTextField.snp.makeConstraints { make in
            make.top.equalTo(spaceNeededTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(vehicleTitleLabel)
        vehicleTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(spaceNeededTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(vehicleTextField)
        vehicleTextField.snp.makeConstraints { make in
            make.top.equalTo(vehicleTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(priceTitleLabel)
        priceTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(vehicleTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(priceTextField)
        priceTextField.snp.makeConstraints { make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(15)
            make.width.equalTo(view.frame.width - 40)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(pickUpDateTitleLabel)
        pickUpDateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(choosePickUpDateButton)
        choosePickUpDateButton.snp.makeConstraints { make in
            make.top.equalTo(pickUpDateTitleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(30)
            make.width.equalTo(120)
        }
        
        scrollView.addSubview(pickUpDateLabel)
        pickUpDateLabel.snp.makeConstraints { make in
            make.top.equalTo(choosePickUpDateButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        scrollView.addSubview(placeOrderButton)
        placeOrderButton.snp.makeConstraints { make in
            make.top.equalTo(pickUpDateLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
        
//        scrollView.addSubview(calendarView)
//        calendarView.snp.makeConstraints { make in
//            make.top.equalTo(priceTextField.snp.bottom).offset(30)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(400)
//            make.width.equalTo(200)
//        }

    }
}

extension PlaceOrderViewController: CalendarViewDataSource, CalendarViewDelegate {
    func calendar(_ calendar: KDCalendar.CalendarView, canSelectDate date: Date) -> Bool {
        return true
    }
    
    func startDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = -3
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return threeMonthsAgo
    }
    
    func endDate() -> Date {
        var dateComponents = DateComponents()
        dateComponents.month = 1
        let today = Date()
        let threeMonthsAgo = self.calendarView.calendar.date(byAdding: dateComponents, to: today)!
        return threeMonthsAgo
    }

    func headerString(_ date: Date) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let monthString = dateFormatter.string(from: date)
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy"
        let yearString = dateFormatter2.string(from: date)
        return "\(monthString) \(yearString)"
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didScrollToMonth date: Date) {
        
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didSelectDate date: Date, withEvents events: [KDCalendar.CalendarEvent]) {
        print(getCurrentDate(date: date, date2: date))
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didDeselectDate date: Date) {
        
    }

    func calendar(_ calendar: KDCalendar.CalendarView, didLongPressDate date: Date, withEvents events: [KDCalendar.CalendarEvent]?) {
        
    }
    
    
}

extension PlaceOrderViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == weightTextField || textField == priceTextField {
            var result = true

            if string.count > 0 {
                let disallowedCharacterSet = NSCharacterSet(charactersIn: "0123456789").inverted
                let replacementStringIsLegal = string.rangeOfCharacter(from: disallowedCharacterSet) == nil
                result = replacementStringIsLegal
            }
            
            let currentString = (textField.text ?? "") as NSString
            let newString = currentString.replacingCharacters(in: range, with: string)


            return result
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismiss(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

}
