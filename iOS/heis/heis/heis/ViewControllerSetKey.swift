//
//  ViewControllerTracerKey.swift
//  heis
//
//  Created by l00p on 9/1/16.
//  Copyright © 2016 heis. All rights reserved.
//

// This ViewController is for setting up the peer-to-peer network using Multipeer Connectivity
// Right now, this just shows the user's own location with a static map set by user in ViewControllerSetGame
// and will transition to the appropriate tracer/traitor ViewController when the start button is pressed

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
        print("gameRole 1 \(gameRole)")

        super.viewDidLoad()
        print("gameRole 2 \(gameRole)")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        var coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)
        
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == .AuthorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.myLocationEnabled = true
            
        }
    }
    
    @IBAction func startGameButton(sender: UIButton) {
        if (gameRole == true) {
            self.performSegueWithIdentifier("setKey-tracerPlay", sender: self)
            print("gameRole true")
        }
        else {
            self.performSegueWithIdentifier("setKey-traitorPlay", sender: self)
            print("gameRole false")
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "setKey-tracerPlay") {
            var VCSetGame = segue.destinationViewController as! ViewControllerTracerPlay;
            VCSetGame.gameZoomLevel = gameZoomLevel
            VCSetGame.gameLatitude = gameLatitude
            VCSetGame.gameLongitude = gameLongitude
            VCSetGame.gameRole = gameRole
        }
        if (segue.identifier == "setKey-traitorPlay") {
            var VCSetGame = segue.destinationViewController as! ViewControllerTraitorPlay;
            VCSetGame.gameZoomLevel = gameZoomLevel
            VCSetGame.gameLatitude = gameLatitude
            VCSetGame.gameLongitude = gameLongitude
            VCSetGame.gameRole = gameRole
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
