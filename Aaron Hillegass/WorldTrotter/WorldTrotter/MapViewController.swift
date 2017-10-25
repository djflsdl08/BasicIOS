//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 김예진 on 2017. 10. 25..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    var mapView : MKMapView!
   // let currentLocationButton = UIButton()
   // let locationManager = CLLocationManager()
    
    override func loadView() {
        mapView = MKMapView()   // Create a map view
        
        view = mapView
        
        let segmentedControl = UISegmentedControl(items : ["Standard","Hybrid","Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(mapTypeChanged(segControl:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        //let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.topAnchor)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo:topLayoutGuide.bottomAnchor, constant: 8)
        //let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        //let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func mapTypeChanged(segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0 : mapView.mapType = .standard
        case 1 : mapView.mapType = .hybrid
        case 2 : mapView.mapType = .satellite
        default : break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // print("MapViewController loaded its view.")
        // userLocation()
    }
    
    // MARK : Appear the location of user. -> Added 'Privacy - Location When In Use Usage Description' at Info.plist
    /*
    func userLocation() {
        currentLocationButton.setTitle("current Location", for : .normal)
        currentLocationButton.setTitleColor(UIColor.blue, for: .normal)
        currentLocationButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.addTarget(self, action: #selector(currentLocation(sender:)), for: .touchUpInside)
        view.addSubview(currentLocationButton)
        
        let bottomConstraint = currentLocationButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant : -8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint = currentLocationButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint = currentLocationButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        bottomConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    func currentLocation(sender: AnyObject) {
        print("click")
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        
        mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - " + error.localizedDescription, terminator: "")
    }
    */
    override func viewWillAppear(_ animated: Bool) {
       // print("viewWillAppear")
    }
    
}
