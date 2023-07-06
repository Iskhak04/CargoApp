//
//  NavigationViewController.swift
//  CargoApp
//
//  Created by Iskhak Zhutanov on 05.07.23.
//

import UIKit
import MapboxCoreNavigation
import MapboxNavigation
import MapboxDirections
import MapboxMaps
import SnapKit

class ViewController: UIViewController, NavigationMapViewDelegate, NavigationViewControllerDelegate, UIGestureRecognizerDelegate {
    
    typealias ActionHandler = (UIAlertAction) -> Void
    var simulationIsEnabled = true
    
    //ahunbaeva sheralieva
    //42.843936, 74.552365
    var pickUpCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.843936, longitude: 74.552365)
    
    //chaychana alai
    //42.85838767938133, 74.56804420013977
    var dropOffCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 42.85838767938133, longitude: 74.56804420013977)
    
    lazy var pickUpButton: UIButton = {
        let view = UIButton()
        view.setTitle("Pick Up", for: .normal)
        view.backgroundColor = .systemGreen
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(pickUpButtonClicked), for: .touchUpInside)
        return view
    }()
    
    lazy var startButton: UIButton = {
        let view = UIButton()
        view.setTitle("Start", for: .normal)
        view.backgroundColor = .systemBlue
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(performAction), for: .touchUpInside)
        return view
    }()
    
    lazy var dropOffButton: UIButton = {
        let view = UIButton()
        view.setTitle("Drop Off", for: .normal)
        view.backgroundColor = .systemRed
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 10
        view.addTarget(self, action: #selector(dropOffButtonClicked), for: .touchUpInside)
        return view
    }()
        
    var navigationMapView: NavigationMapView! {
        didSet {
            // After the start of active turn-by-turn navigation, the previous `navigationMapView` should be `nil` and removed from super view. It could avoid the location update in the background to disturb the turn-by-turn navigation guidance.
            if let navigationMapView = oldValue {
                navigationMapView.removeFromSuperview()
            }
            
            if navigationMapView != nil {
                setupNavigationMapView()
            }
        }
    }
    
    var routeResponse: RouteResponse? {
        didSet {
            guard let routes = routeResponse?.routes, let currentRoute = routes.first else {
                navigationMapView?.removeRoutes()
                navigationMapView?.removeRouteDurations()
                navigationMapView?.removeWaypoints()
                waypoints.removeAll()
                return
            }
            navigationMapView.show(routes)
            navigationMapView.showWaypoints(on: currentRoute)
        }
    }
    
    var waypoints: [Waypoint] = []
    
    private let clearButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationMapView == nil {
            navigationMapView = NavigationMapView(frame: view.bounds)
        }
        
        
    }
    
    func setupNavigationMapView() {
        navigationMapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        navigationMapView.delegate = self
        navigationMapView.userLocationStyle = .puck2D()
        
        let navigationViewportDataSource = NavigationViewportDataSource(navigationMapView.mapView, viewportDataSourceType: .raw)
        navigationViewportDataSource.options.followingCameraOptions.zoomUpdatesAllowed = false
        navigationViewportDataSource.followingMobileCamera.zoom = 15.0
        navigationMapView.navigationCamera.viewportDataSource = navigationViewportDataSource
        
        view.addSubview(navigationMapView)
        
        setupStartButton()
    }
    
    func setupStartButton() {
        view.addSubview(pickUpButton)
        pickUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        view.addSubview(dropOffButton)
        dropOffButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalTo(pickUpButton.snp.right).offset(10)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.right.equalTo(view.snp.right).offset(-10)
            make.height.equalTo(40)
            make.width.equalTo(100)
        }
    }
    
    func requestRoute(secondLocation: CLLocationCoordinate2D) {
        //guard waypoints.count > 0 else { return }
        guard let currentCoordinate = navigationMapView.mapView.location.latestLocation?.coordinate else {
            print("User location is not valid. Make sure to enable Location Services.")
            return
        }

        let userWaypoint = Waypoint(coordinate: currentCoordinate)
        // Change the coordinate accuracy of `Waypoint` to negative before adding it to the `waypoints`. Thus the route requested on the `waypoints` is considered viable.
        
        userWaypoint.coordinateAccuracy = -1
        waypoints.insert(userWaypoint, at: 0)
        
        let secondWaypoint = Waypoint(coordinate: secondLocation)
        waypoints.append(secondWaypoint)
        let navigationRouteOptions = NavigationRouteOptions(waypoints: waypoints)
        
        Directions.shared.calculate(navigationRouteOptions) { [weak self] (_, result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
                self?.waypoints.removeLast()
            case .success(let response):
                guard let routes = response.routes else { return }
                self?.routeResponse = response
                self?.navigationMapView.show(routes)
                if let currentRoute = routes.first {
                    self?.navigationMapView.showWaypoints(on: currentRoute)
                }
            }
        }
    }
    
    @objc func pickUpButtonClicked() {
        requestRoute(secondLocation: pickUpCoordinate)
    }
    
    @objc func dropOffButtonClicked() {
        requestRoute(secondLocation: dropOffCoordinate)
    }
    
    @objc func performAction(_ sender: Any) {
        if waypoints.count == 0 {
            let alert = UIAlertController(title: "No Route", message: "Please select eithr \"Pick Up\" or \"Drop Of\"", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
        presentNavigationViewController(.courseView())
    }
    
    
    
    func presentNavigationViewController(_ userLocationStyle: UserLocationStyle? = nil) {
        guard let routeResponse = routeResponse else { return }

        let indexedRouteResponse = IndexedRouteResponse(routeResponse: routeResponse, routeIndex: 0)
        let navigationService = MapboxNavigationService(indexedRouteResponse: indexedRouteResponse,
                                                        customRoutingProvider: NavigationSettings.shared.directions,
                                                        credentials: NavigationSettings.shared.directions.credentials,
                                                        simulating: simulationIsEnabled ? .always : .onPoorGPS)
        let navigationOptions = NavigationOptions(navigationService: navigationService)
        let navigationViewController = NavigationViewController(for: indexedRouteResponse,
                                                                navigationOptions: navigationOptions)
        navigationViewController.routeLineTracksTraversal = true
        navigationViewController.delegate = self
        navigationViewController.modalPresentationStyle = .fullScreen
        
        // If not customizing the `NavigationMapView.userLocationStyle`, it defaults as the `UserLocationStyle.courseView(_:)`.
        navigationViewController.navigationMapView?.userLocationStyle = userLocationStyle

        navigationViewController.navigationMapView?.mapView.mapboxMap.style.uri = navigationMapView.mapView?.mapboxMap.style.uri
        
        present(navigationViewController, animated: true) {
            // When start navigation, the previous `navigationMapView` should be `nil` and removed from super view. The niled out `navigationMapView` could avoid the location provider sending location update in the background, which will disturb the turn-by-turn navigation guidance.
            self.navigationMapView = nil
        }
    }
    
    func navigationViewControllerDidDismiss(_ navigationViewController: NavigationViewController, byCanceling canceled: Bool) {
        routeResponse = nil
        dismiss(animated: true, completion: nil)
        if navigationMapView == nil {
            navigationMapView = NavigationMapView(frame: view.bounds)
        }
    }
}
