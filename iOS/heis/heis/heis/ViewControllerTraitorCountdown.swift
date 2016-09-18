//
//  ViewControllerTraitorCountdown.swift
//  heis
//
//  Created by l00p on 9/6/16.
//  Copyright © 2016 heis. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewControllerTraitorCountdown: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var countdownTimerLabel: UILabel!
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
    var gameCountdownMinutes: Int!
    var count = 60
    override func viewDidLoad() {
        super.viewDidLoad()
        count = gameCountdownMinutes * 2
        
        var timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: Selector("countdownTimerAction"), userInfo: nil, repeats: true)
        
    }
    
    func countdownTimerAction(){
        let minutes = count / 60
        let seconds = count % 60
        if (seconds == 0) {
            countdownTimerLabel.text = "\(minutes):00"
        }
        else if (seconds < 10) {
            countdownTimerLabel.text = "\(minutes):0\(seconds)"
        }
        else {
            countdownTimerLabel.text = "\(minutes):\(seconds)"
        }
        
        if (count == 0) {
            self.performSegue(withIdentifier: "traitorCountdown-traitorPlay", sender: self)
        }
        
        
        count-=1
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if (segue.identifier == "traitorCountdown-traitorPlay") {
            var VCSetGame = segue.destination as! ViewControllerTraitorPlay;
            VCSetGame.gameZoomLevel = gameZoomLevel
            VCSetGame.gameLatitude = gameLatitude
            VCSetGame.gameLongitude = gameLongitude
            VCSetGame.gameRole = gameRole
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
