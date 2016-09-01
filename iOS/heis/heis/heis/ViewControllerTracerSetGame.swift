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
    let zoomIncButton = UIButton(frame: CGRect(x: 150, y: 400, width: 120, height: 40))
    let zoomDecButton = UIButton(frame: CGRect(x: 150, y: 460, width: 120, height: 40))
    let zoomSetButton = UIButton(frame: CGRect(x: 210, y: 600, width: 180, height: 40))
    var zoomLevel = 15.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Programatically creating zoom increase button
        zoomIncButton.backgroundColor = .blueColor()
        zoomIncButton.setTitle("Increase Zoom", forState: .Normal)
        zoomIncButton.addTarget(self, action: #selector(zoomIncButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(zoomIncButton)
        
        // Programatically creating zoom decrease button
        zoomDecButton.backgroundColor = .blackColor()
        zoomDecButton.setTitle("Decreasom Zoom", forState: .Normal)
        zoomDecButton.addTarget(self, action: #selector(zoomDecButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(zoomDecButton)
        
        // Programatically creating zoom set button
        zoomSetButton.backgroundColor = .greenColor()
        zoomSetButton.setTitle("Set Zoom/Location", forState: .Normal)
        zoomSetButton.addTarget(self, action: #selector(zoomSetButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(zoomSetButton)

    }
    
    func zoomIncButtonAction(sender: UIButton!) {
        zoomLevel = zoomLevel + 1
    }
    
    func zoomDecButtonAction(sender: UIButton!) {
        zoomLevel = zoomLevel - 1
    }
    
    func zoomSetButtonAction(sender: UIButton!) {
        // zoomLevel will be stored to use as game's zoom level, but for now it's just printed out
        print(zoomLevel)
        // Then the program will transition to provide the game key
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
            //HERE IS CAMERA
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: Float(zoomLevel), bearing: 0, viewingAngle: 0)
            
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
