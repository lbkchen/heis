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
    var gameCountdownMinutes: Int!
    
    override func viewDidLoad() {
        print("gameRole 1 \(gameRole)")

        super.viewDidLoad()
        print("gameRole 2 \(gameRole)")
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()

        let coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)
        
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            
        }
    }
    
    @IBAction func startGameButton(_ sender: UIButton) {
        if (gameRole == true) {
            self.performSegue(withIdentifier: "setKey-tracerCountdown", sender: self)
            print("gameRole true")
        }
        else {
            self.performSegue(withIdentifier: "setKey-traitorCountdown", sender: self)
            print("gameRole false")
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "setKey-tracerCountdown") {
            let VCSetGame = segue.destination as! ViewControllerTracerCountdown;
            VCSetGame.gameZoomLevel = gameZoomLevel
            VCSetGame.gameLatitude = gameLatitude
            VCSetGame.gameLongitude = gameLongitude
            VCSetGame.gameRole = gameRole
            VCSetGame.gameCountdownMinutes = gameCountdownMinutes
        }
        if (segue.identifier == "setKey-traitorCountdown") {
            let VCSetGame = segue.destination as! ViewControllerTraitorCountdown;
            VCSetGame.gameZoomLevel = gameZoomLevel
            VCSetGame.gameLatitude = gameLatitude
            VCSetGame.gameLongitude = gameLongitude
            VCSetGame.gameRole = gameRole
            VCSetGame.gameCountdownMinutes = gameCountdownMinutes
        }

    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
