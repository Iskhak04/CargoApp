//
//  MapViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 07.07.23.
//

import UIKit
import MapKit

final class MapViewController: UIViewController {
    
    var matchingItems: [MKMapItem] = []
    var selectedPin: MKPlacemark? = nil
    var callBack: ((CLLocationCoordinate2D)-> Void)?
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        return view
    }()
    
    private lazy var locationsTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.isHidden = true
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        view.delegate = self
        view.placeholder = "Search location"
        return view
    }()
    
    private lazy var addLocationButton: UIButton = {
        let view = UIButton()
        view.setTitle("Add", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(addLocationButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var cancelLocationButton: UIButton = {
        let view = UIButton()
        view.setTitle("Cancel", for: .normal)
        view.backgroundColor = .label
        view.setTitleColor(.systemBackground, for: .normal)
        view.addTarget(self, action: #selector(cancelLocationButtonClicked), for: .touchUpInside)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search by ID"
        searchBar.sizeToFit()
        navigationItem.hidesBackButton = true
        searchBar.isTranslucent = false
        navigationItem.titleView = searchBar
        //navigationItem.titleView = searchBar
        layout()
    }
    
    @objc private func cancelLocationButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addLocationButtonClicked() {
        
        guard let pin = selectedPin else { return }
        
        callBack?(pin.coordinate)
        
        navigationController?.popViewController(animated: true)
    }
    
    private func layout() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(locationsTableView)
        locationsTableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(addLocationButton)
        addLocationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
        
        view.addSubview(cancelLocationButton)
        cancelLocationButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.left.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(60)
        }
    }
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
        selectedPin = placemark
        // clear existing pins
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
        let state = placemark.administrativeArea {
            annotation.subtitle = "(city) (state)"
        }
        mapView.addAnnotation(annotation)
        let viewRegion = MKCoordinateRegion(center: placemark.coordinate, latitudinalMeters: 300000, longitudinalMeters: 300000)
        self.mapView.setRegion(viewRegion, animated: true)
    }
}

extension MapViewController: UISearchBarDelegate {
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        locationsTableView.isHidden = false
        guard let searchBarText = searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        self.locationsTableView.isHidden = false
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.locationsTableView.reloadData()
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        filteredOrders = orders
//        ordersCollectionView.reloadData()
//        searchBar.resignFirstResponder()
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else { return }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
        request.region = mapView.region
        self.locationsTableView.isHidden = false
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.matchingItems = response.mapItems
            self.locationsTableView.reloadData()
        }
    }
    
    
}

extension MapViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        let selectedItem = matchingItems[indexPath.row].placemark
        cell.textLabel?.text = selectedItem.name
        let address = "\(selectedItem.thoroughfare ?? ""), \(selectedItem.locality ?? ""), \(selectedItem.subLocality ?? ""), \(selectedItem.administrativeArea ?? ""), \(selectedItem.postalCode ?? ""), \(selectedItem.country ?? "")"
        cell.detailTextLabel?.text = address
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = matchingItems[indexPath.row].placemark
        dropPinZoomIn(placemark: selectedItem)
        locationsTableView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: UISearchControllerDelegate {
    
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        if annotationView == nil {
            //create view
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom")
        } else {
            //assign annotation
            annotationView?.annotation = annotation
        }
        
        let image = UIImage(systemName: "arrow.up.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
        
        annotationView?.backgroundColor = .white
        annotationView?.layer.cornerRadius = 19
        annotationView?.setPin(image: image!, with: .systemGreen)
        
//        switch annotation.title {
//        case "Pick Up":
//
//        case "Drop Off":
//            let image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
//
//            annotationView?.backgroundColor = .white
//            annotationView?.layer.cornerRadius = 19
//            annotationView?.setPin(image: image!, with: .systemRed)
//        default:
//            ()
//        }
        
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
