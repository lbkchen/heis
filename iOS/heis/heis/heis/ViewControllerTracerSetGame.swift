//
//  ViewControllerTracerSetGame.swift
//  heis
//
//  Created by l00p on 8/30/16.
//  Copyright © 2016 heis. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewControllerTracerSetGame: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
    }
    // Baffling code
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            var locValue:CLLocationCoordinate2D = manager.location!.coordinate
            //latitude = locValue.latitude
            //longitude = locValue.longitude
            var speed: CLLocationSpeed = manager.location!.speed
            //speedVal = speed.advancedBy(1.0)
            var course: CLLocationDirection = manager.location!.course
            //courseVal = course.advancedBy(2.5)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
