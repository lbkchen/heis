//
//  ViewControllerTracerKey.swift
//  heis
//
//  Created by l00p on 9/1/16.
//  Copyright © 2016 heis. All rights reserved.
//


// This View Controller should provide a key for the game to be set
// To work on-- transferring data between views (i.e. game location and zoom and role)
// Lookey here: http://stackoverflow.com/questions/24222640/passing-data-between-view-controllers-in-swift
// And after that, transferring data between users!1!


import UIKit
import GoogleMaps

class ViewControllerSetKey: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            //mapView.myLocationEnabled = true
            
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)
            
            var locValue:CLLocationCoordinate2D = manager.location!.coordinate
            //latitude = locValue.latitude
            //longitude = locValue.longitude
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

/*
import UIKit
import GoogleMaps


class ViewControllerSetKey: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!

   /* override func loadView() {
        print("we")
        let camera = GMSCameraPosition.cameraWithLatitude(33, longitude: 33, zoom: 15)
        mapView = GMSMapView.mapWithFrame(.zero, camera: camera)
        self.view = mapView
    }*/

    override func viewDidLoad() {
        print("le")
        super.viewDidLoad()
        
        print(gameLongitude)
        print(gameLatitude)
        print(gameZoomLevel)
        print(gameRole)

        // Do view setup here.
        //let camera = GMSCameraPosition.cameraWithLatitude(gameLatitude, longitude: gameLongitude, zoom: Float(gameZoomLevel))
        //let camera = GMSCameraPosition.cameraWithLatitude(33, longitude: 33, zoom: 15.0)

        //mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
        //mapView.myLocationEnabled = true

    }

    
}*/
