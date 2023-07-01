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
    
    //Birmingham, Al
    //33.515915842143556, -86.80900570276167
    
    //Lometa, TX
    //31.217031101244036, -98.39342797721083
    
    
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Load Details"
        layout()
        
        //adding pin (annotatin) for pick up location
        addAnnotation(location: pickUpLocation, title: "Pick Up")
        
        //adding pin (annotatin) for drop off location
        addAnnotation(location: dropOffLocation, title: "Drop Off")
        
        //drawing a route between pick up and drop off locations
        drawRoute(pickUpLocation: pickUpLocation, dropOffLocatin: dropOffLocation)
        
        //zooming in to the center between pick up and drop off locations
        zoomToRegion(firstLocation: pickUpLocation, secondLocation: dropOffLocation)
    }
    
    func addAnnotation(location: CLLocation, title: String?) {
        let point = MKPointAnnotation()
        point.title = title
        point.coordinate = location.coordinate
        self.mapView.addAnnotation(point)
    }
    
    private func layout() {
        view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.left.right.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    func zoomToRegion(firstLocation: CLLocation, secondLocation: CLLocation) {
        let centerLatitude = (firstLocation.coordinate.latitude + secondLocation.coordinate.latitude) / 2
        let centerLongitude = (firstLocation.coordinate.longitude + secondLocation.coordinate.longitude) / 2
        let centerLocatoin = CLLocation(latitude: centerLatitude, longitude: centerLongitude)
        
        let viewRegion = MKCoordinateRegion(center: centerLocatoin.coordinate, latitudinalMeters: 1000000, longitudinalMeters: 1000000)
        self.mapView.setRegion(viewRegion, animated: true)
        
    }
    
    func drawRoute(pickUpLocation: CLLocation, dropOffLocatin: CLLocation) {
        
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
    
    func addPolyline(coordinates: [CLLocation]) {
        
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
            annotationView?.layer.cornerRadius = 20
            annotationView?.setPin(image: image!, with: .systemGreen)
        case "Drop Off":
            let image = UIImage(systemName: "arrow.down.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .large))
            
            annotationView?.backgroundColor = .white
            annotationView?.layer.cornerRadius = 20
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
