//
//  ViewControllerTracerSetGame.swift
//  heis
//
//  Created by l00p on 8/30/16.
//  Copyright © 2016 heis. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewControllerSetGame: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let zoomIncButton = UIButton(frame: CGRect(x: 150, y: 300, width: 140, height: 40))
    let zoomDecButton = UIButton(frame: CGRect(x: 150, y: 360, width: 140, height: 40))
    
    @IBOutlet weak var countdownStepper: UIStepper!
    @IBOutlet weak var countdownLabel: UILabel!

    @IBOutlet weak var chooseRole: UISegmentedControl!

    var zoomLevel = 16.0
    var latitude = 0.0
    var longitude = 0.0
    var setGameRole = true
    var countdownMinutes = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Programatically creating zoom increase button
        zoomIncButton.backgroundColor = UIColor.blue
        zoomIncButton.setTitle("Increase Zoom", for: UIControlState())
        zoomIncButton.addTarget(self, action: #selector(zoomIncButtonAction), for: .touchUpInside)
        self.view.addSubview(zoomIncButton)
        
        // Programatically creating zoom decrease button
        zoomDecButton.backgroundColor = UIColor.green
        zoomDecButton.setTitle("Decrease Zoom", for: UIControlState())
        zoomDecButton.addTarget(self, action: #selector(zoomDecButtonAction), for: .touchUpInside)
        self.view.addSubview(zoomDecButton)
        
        // Properties of countdownStepper
        countdownStepper.wraps = true
        countdownStepper.autorepeat = true
        countdownStepper.maximumValue = 0
        countdownStepper.maximumValue = 30
        countdownStepper.value = 3
    }
    @IBAction func countdownStepperAction(_ sender: UIStepper) {
        countdownMinutes = Int(sender.value)
        countdownLabel.text = "Countdown: \(Int(sender.value)) min"
        
    }

    @IBAction func startGameButton(_ sender: AnyObject) {
        // zoomLevel will be stored to use as game's zoom level, but for now it's just printed out
        // Ditto above with latitude and longitude and setGameRole (true=tracer, false=traitor)

        /*if (chooseRole.selectedSegmentIndex == 0) {
            setGameRole = true

        }
        else {
            setGameRole = false
        }
        */
    }
 
    func zoomIncButtonAction(_ sender: UIButton!) {
        zoomLevel = zoomLevel + 0.25
    }
    
    func zoomDecButtonAction(_ sender: UIButton!) {
        zoomLevel = zoomLevel - 0.25
    }
    

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: Float(zoomLevel), bearing: 0, viewingAngle: 0)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if (chooseRole.selectedSegmentIndex == 0) {
            setGameRole = true
            
        }
        else {
            setGameRole = false
        }
        let locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        latitude = locValue.latitude
        longitude = locValue.longitude

        if (segue.identifier == "setGame-setKey") {
            let VCSetGame = segue.destination as! ViewControllerSetKey;
            VCSetGame.gameZoomLevel = zoomLevel
            VCSetGame.gameLatitude = latitude
            VCSetGame.gameLongitude = longitude
            VCSetGame.gameRole = setGameRole
            VCSetGame.gameCountdownMinutes = countdownMinutes

            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
