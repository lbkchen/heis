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
    @IBOutlet weak var chooseRole: UISegmentedControl!
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let zoomIncButton = UIButton(frame: CGRect(x: 150, y: 300, width: 140, height: 40))
    let zoomDecButton = UIButton(frame: CGRect(x: 150, y: 360, width: 140, height: 40))
    var zoomLevel = 15.0
    var gameLatitude = 0.0
    var gameLongitude = 0.0
    var setGameRole = true
    
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
        zoomDecButton.setTitle("Decrease Zoom", forState: .Normal)
        zoomDecButton.addTarget(self, action: #selector(zoomDecButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(zoomDecButton)
        
    }
    
    @IBAction func startGameButton(sender: AnyObject) {
        // zoomLevel will be stored to use as game's zoom level, but for now it's just printed out
        // Ditto above with gameLatitude and gameLongitude and setGameRole (true=tracer, false=traitor)
        print(zoomLevel)
        var locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        gameLatitude = locValue.latitude
        gameLongitude = locValue.longitude
        print(gameLatitude)
        print(gameLongitude)
        
        if (chooseRole.selectedSegmentIndex == 0) {
            //performSegueWithIdentifier("setGame-tracerKey", sender: nil)
            setGameRole = true
        }
        else {
            setGameRole = false
        }
        print(setGameRole)
    
        // Then app will transition to view displaying game key
    }
 
    func zoomIncButtonAction(sender: UIButton!) {
        zoomLevel = zoomLevel + 0.25
    }
    
    func zoomDecButtonAction(sender: UIButton!) {
        zoomLevel = zoomLevel - 0.25
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
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
