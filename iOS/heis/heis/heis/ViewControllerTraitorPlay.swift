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
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
 

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}