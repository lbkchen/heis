//
//  ViewControllerTraitorPlay.swift
//  heis
//
//  Created by l00p on 9/4/16.
//  Copyright © 2016 heis. All rights reserved.
//


import UIKit
import GoogleMaps


class ViewControllerTraitorPlay: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var mapView: GMSMapView!
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Sets map
        let coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
