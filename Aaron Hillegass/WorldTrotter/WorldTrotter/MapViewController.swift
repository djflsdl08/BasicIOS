//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by 김예진 on 2017. 10. 25..
//  Copyright © 2017년 Kim,Yejin. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    var mapView : MKMapView!
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
       // print("viewWillAppear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
