//
//  ViewControllerTracer2.swift
//  heis
//
//  Created by l00p on 8/29/16.
//  Copyright © 2016 heis. All rights reserved.
//


import UIKit
import GoogleMaps


class ViewControllerTracer2: UIViewController, CLLocationManagerDelegate {
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
    var minuteTimer = NSTimer()
    var startingX = 70.0
    var startingY = 70.0
    let radianMultiplier = 0.0174533
    var arrowsArray = [CAShapeLayer](count: 3, repeatedValue: CAShapeLayer())
    var lastAccessedVelocity = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Programatically creating location button
        locationButton.backgroundColor = .blueColor()
        locationButton.setTitle("Location", forState: .Normal)
        locationButton.addTarget(self, action: #selector(locationButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(locationButton)
        
        // Programatically creating velocity button
        velocityButton.backgroundColor = .blackColor()
        velocityButton.setTitle("Velocity", forState: .Normal)
        velocityButton.addTarget(self, action: #selector(velocityButtonAction), forControlEvents: .TouchUpInside)
        self.view.addSubview(velocityButton)
        
        // Hide speed label at first
        speedLabel.hidden = true
        
        // Shows clock timer
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("clockTimerAction"), userInfo: nil, repeats: true)
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
    
    func locationButtonAction(sender: UIButton!) {
        
        // Gets rid of old marker
        if (lastAccessedVelocity == true) {
            speedLabel.hidden = true
            
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
        minuteTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(pressedTimerAction), userInfo: nil, repeats: false)
        
    }
    func velocityButtonAction(sender: UIButton!) {
        
        // Gets rid of old marker
        if (lastAccessedVelocity == true) {
            speedLabel.hidden = true
            
        }
        else {
            locationMarker.map = nil
        }
        for i in 0 ..< 3  {
            (arrowsArray[i]).zPosition = -1
        }
        
        // Shows speed
        speedLabel.text = "Velocity: \(speedVal)"
        
        speedLabel.hidden = false
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
        minuteTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(pressedTimerAction), userInfo: nil, repeats: false)
        
    }
    
    func pressedTimerAction() {
        // Displays button again after timer reaches end of cycle
        self.view.addSubview(locationButton)
        self.view.addSubview(velocityButton)
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
            latitude = locValue.latitude
            longitude = locValue.longitude
            var speed: CLLocationSpeed = manager.location!.speed
            speedVal = speed.advancedBy(1.0)
            var course: CLLocationDirection = manager.location!.course
            courseVal = course.advancedBy(2.5)
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
    
    func makeMarker(latitudeVal: Double, longitudeVal: Double, titleVal: String, snippetVal: String, myMapView: GMSMapView)
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
    func drawDirection(angle: Double, speedLineMultiplier: Double, arrowLength: Double) -> [CAShapeLayer] {
        var endingX = 0.0
        var endingY = 0.0
        let startingPoint = CGPointMake(CGFloat(startingX), CGFloat(startingY))
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
        let endingPoint = CGPointMake(CGFloat(endingX), CGFloat(endingY))
        let arrowEndingPoint1 = CGPointMake(CGFloat(arrowEndingX1), CGFloat(arrowEndingY1))
        let arrowEndingPoint2 = CGPointMake(CGFloat(arrowEndingX2), CGFloat(arrowEndingY2))
        // Draws direction line
        arrowsArray[0] = drawLine(startingPoint, toPoint: endingPoint, ofColor: UIColor.blackColor(), inView: self.view)
        
        //Draws the 2 arrow lines
        arrowsArray[1] = drawLine(endingPoint, toPoint: arrowEndingPoint1, ofColor: UIColor.blackColor(), inView: self.view)
        arrowsArray[2] = drawLine(endingPoint, toPoint: arrowEndingPoint2, ofColor: UIColor.blackColor(), inView: self.view)
        
        return arrowsArray
    }
    
    func drawLine(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) -> CAShapeLayer {
        // Design the path
        var path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        
        // Design path in layer
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.strokeColor = lineColor.CGColor
        shapeLayer.lineWidth = 3.0
        return shapeLayer
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

