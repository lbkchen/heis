//
//  ViewControllerTracer2.swift
//  heis
//
//  Created by l00p on 8/29/16.
//  Copyright © 2016 heis. All rights reserved.
//


import UIKit
import GoogleMaps

// TO DO: make countdown pages before TracerPlay and Traitor Play

class ViewControllerTracerPlay: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    let locationButton = UIButton(frame: CGRect(x: 150, y: 400, width: 75, height: 40))
    let velocityButton = UIButton(frame: CGRect(x: 150, y: 460, width: 75, height: 40))
    var locationMarker = GMSMarker()
    @IBOutlet weak var clockTimerLabel: UILabel!
    var count = 0
    @IBOutlet weak var speedLabel: UILabel!
    var latitude = 0.0
    var longitude = 0.0
    var speedVal = 0.0
    var courseVal = 0.0
    var minuteTimer = Timer()
    var startingX = 70.0
    var startingY = 70.0
    let radianMultiplier = 0.0174533
    var arrowsArray = [CAShapeLayer](repeating: CAShapeLayer(), count: 3)
    var lastAccessedVelocity = false
    
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Programatically creating location button
        locationButton.backgroundColor = UIColor.blue
        locationButton.setTitle("Location", for: UIControlState())
        locationButton.addTarget(self, action: #selector(locationButtonAction), for: .touchUpInside)
        self.view.addSubview(locationButton)
        
        // Programatically creating velocity button
        velocityButton.backgroundColor = UIColor.green
        velocityButton.setTitle("Velocity", for: UIControlState())
        velocityButton.addTarget(self, action: #selector(velocityButtonAction), for: .touchUpInside)
        self.view.addSubview(velocityButton)
        
        // Hide speed label at first
        speedLabel.isHidden = true
        
        // Shows clock timer
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewControllerTracerPlay.clockTimerAction), userInfo: nil, repeats: true)
        
        // Sets map
        var coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)

    }
    
    func clockTimerAction(){
        let minutes = count / 60
        let seconds = count % 60
        if (seconds == 0) {
            clockTimerLabel.text = "\(minutes):00"
        }
        else if (seconds < 10) {
            clockTimerLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            clockTimerLabel.text = "\(minutes):\(seconds)"
        }
        count+=1
    }
    
    func locationButtonAction(_ sender: UIButton!) {
        
        // Gets rid of old marker
        if (lastAccessedVelocity == true) {
            speedLabel.isHidden = true
            
        }
        else {
            locationMarker.map = nil
        }
        
        for i in 0 ..< 3  {
            (arrowsArray[i]).zPosition = -1
        }
        
        // Adds marker
        locationMarker = makeMarker(latitude, longitudeVal: longitude, titleVal: "Ya bish", snippetVal: "USA", myMapView: mapView)
        
        // Removes buttons
        locationButton.removeFromSuperview()
        velocityButton.removeFromSuperview()
        
        lastAccessedVelocity = false
        
        // Start the timer
        minuteTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(clueTimerAction), userInfo: nil, repeats: false)
        
    }
    func velocityButtonAction(_ sender: UIButton!) {
        
        // Gets rid of old marker
        if (lastAccessedVelocity == true) {
            speedLabel.isHidden = true
            
        }
        else {
            locationMarker.map = nil
        }
        for i in 0 ..< 3  {
            (arrowsArray[i]).zPosition = -1
        }
        
        // Shows speed
        speedLabel.text = "Velocity: \(speedVal)"
        
        speedLabel.isHidden = false
        self.view.addSubview(speedLabel)
        
        var arrow = drawDirection(courseVal, speedLineMultiplier: 50.0, arrowLength: 10.0)
        
        // Adds course arrow
        for i in 0 ..< 3  {
            view.layer.addSublayer(arrow[i])
        }
        
        // Removes buttons
        locationButton.removeFromSuperview()
        velocityButton.removeFromSuperview()
        
        lastAccessedVelocity = true
        
        // Start the timer
        minuteTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(clueTimerAction), userInfo: nil, repeats: false)
        
    }
    
    func clueTimerAction() {
        // Displays button again after timer reaches end of cycle
        self.view.addSubview(locationButton)
        self.view.addSubview(velocityButton)
    }
    
    // Baffling code
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
            
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            latitude = locValue.latitude
            longitude = locValue.longitude
            let speed: CLLocationSpeed = manager.location!.speed
            speedVal = speed.advanced(by: 1.0)
            let course: CLLocationDirection = manager.location!.course
            courseVal = course.advanced(by: 2.5)
        }
        
    }
    
    /*
     // Makes a mapView in a predetermined location
     func makeMapView(latitudeVal: Double, longitudeVal: Double, zoomVal: Float) -> GMSMapView {
     // Create a GMSCameraPosition that tells the map to display the
     // coordinate -33.86,151.20 at zoom level 6.
     let camera = GMSCameraPosition.cameraWithLatitude(latitudeVal, longitude: longitudeVal, zoom: zoomVal)
     let mapView = GMSMapView.mapWithFrame(CGRect.zero, camera: camera)
     mapView.myLocationEnabled = true
     return mapView
     }
     */
    
    func makeMarker(_ latitudeVal: Double, longitudeVal: Double, titleVal: String, snippetVal: String, myMapView: GMSMapView)
        -> GMSMarker {
            // Returns a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: latitudeVal, longitude: longitudeVal)
            marker.title = titleVal
            marker.snippet = snippetVal
            marker.map = myMapView
            marker.appearAnimation = kGMSMarkerAnimationPop
            return marker
    }
    
    /*
     // Old code that programmatically creates speed label
     func makeSpeedLabel(speed: Double) -> UILabel {
     print("speed: \(speedVal)")
     speedLabel.text = "Velocity: \(speedVal)"
     return speedLabel
     }
     */
    
    // Draws a line pointing in a course angle's direction
    func drawDirection(_ angle: Double, speedLineMultiplier: Double, arrowLength: Double) -> [CAShapeLayer] {
        var endingX = 0.0
        var endingY = 0.0
        let startingPoint = CGPoint(x: CGFloat(startingX), y: CGFloat(startingY))
        var arrowEndingX1 = 0.0
        var arrowEndingY1 = 0.0
        var arrowEndingX2 = 0.0
        var arrowEndingY2 = 0.0
        
        // Different cases for angles in different quadrants
        if (angle >= 0 && angle <= 90){
            // Sets the ending X and Y coordinates for the direction line, also starting point of arrows
            endingX = startingX + speedLineMultiplier * cos(radianMultiplier * (90 - angle))
            endingY = startingY - speedLineMultiplier * sin(radianMultiplier * (90 - angle))
            // Sets the X and Y coords for the ending point of the arrows
            arrowEndingX1 = endingX - arrowLength * cos(radianMultiplier * (90 + 45 - angle))
            arrowEndingY1 = endingY + arrowLength * sin(radianMultiplier * (90 + 45 - angle))
            arrowEndingX2 = endingX - arrowLength * sin(radianMultiplier * (90 + 45 - angle))
            arrowEndingY2 = endingY - arrowLength * cos(radianMultiplier * (90 + 45 - angle))
        }
        else if (angle > 90 && angle <= 180){
            endingX = startingX + speedLineMultiplier * sin(radianMultiplier * (180 - angle))
            endingY = startingY + speedLineMultiplier * cos(radianMultiplier * (180 - angle))
            arrowEndingX1 = endingX + arrowLength * cos(radianMultiplier * (180 + 45 - angle))
            arrowEndingY1 = endingY - arrowLength * sin(radianMultiplier * (180 + 45 - angle))
            arrowEndingX2 = endingX - arrowLength * sin(radianMultiplier * (180 + 45 - angle))
            arrowEndingY2 = endingY - arrowLength * cos(radianMultiplier * (180 + 45 - angle))
        }
        else if (angle > 180 && angle <= 270){
            endingX = startingX - speedLineMultiplier * cos(radianMultiplier * (270 - angle))
            endingY = startingY + speedLineMultiplier * sin(radianMultiplier * (270 - angle))
            arrowEndingX1 = endingX + arrowLength * cos(radianMultiplier * (270 + 45 - angle))
            arrowEndingY1 = endingY - arrowLength * sin(radianMultiplier * (270 + 45 - angle))
            arrowEndingX2 = endingX + arrowLength * sin(radianMultiplier * (270 + 45 - angle))
            arrowEndingY2 = endingY + arrowLength * cos(radianMultiplier * (270 + 45 - angle))
        }
        else if (angle > 270 && angle <= 361){
            endingX = startingX - speedLineMultiplier * sin(radianMultiplier * (360 - angle))
            endingY = startingY - speedLineMultiplier * cos(radianMultiplier * (360 - angle))
            arrowEndingX1 = endingX - arrowLength * cos(radianMultiplier * (360 + 45 - angle))
            arrowEndingY1 = endingY + arrowLength * sin(radianMultiplier * (360 + 45 - angle))
            arrowEndingX2 = endingX + arrowLength * sin(radianMultiplier * (360 + 45 - angle))
            arrowEndingY2 = endingY + arrowLength * cos(radianMultiplier * (360 + 45 - angle))
        }
        else{
            print("Invalid angle: \(angle)")
        }
        let endingPoint = CGPoint(x: CGFloat(endingX), y: CGFloat(endingY))
        let arrowEndingPoint1 = CGPoint(x: CGFloat(arrowEndingX1), y: CGFloat(arrowEndingY1))
        let arrowEndingPoint2 = CGPoint(x: CGFloat(arrowEndingX2), y: CGFloat(arrowEndingY2))
        // Draws direction line
        arrowsArray[0] = drawLine(startingPoint, toPoint: endingPoint, ofColor: UIColor.black, inView: self.view)
        
        //Draws the 2 arrow lines
        arrowsArray[1] = drawLine(endingPoint, toPoint: arrowEndingPoint1, ofColor: UIColor.black, inView: self.view)
        arrowsArray[2] = drawLine(endingPoint, toPoint: arrowEndingPoint2, ofColor: UIColor.black, inView: self.view)
        
        return arrowsArray
    }
    
    func drawLine(_ start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) -> CAShapeLayer {
        // Design the path
        let path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        // Design path in layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 3.0
        return shapeLayer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

