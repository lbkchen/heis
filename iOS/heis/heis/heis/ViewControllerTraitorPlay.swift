//
//  ViewControllerTraitorPlay.swift
//  heis
//
//  Created by l00p on 9/4/16.
//  Copyright © 2016 heis. All rights reserved.
//


import UIKit
import GoogleMaps
import MultipeerConnectivity


class ViewControllerTraitorPlay: UIViewController, CLLocationManagerDelegate, MCSessionDelegate, MCBrowserViewControllerDelegate {
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    var gameZoomLevel: Double!
    var gameLatitude: Double!
    var gameLongitude: Double!
    var gameRole: Bool!
    let startSessionButton = UIButton(frame: CGRect(x: 150, y: 200, width: 200, height: 40))
    let sendDataButton = UIButton(frame: CGRect(x: 150, y: 400, width: 200, height: 40))
    var peerID: MCPeerID!
    var mcSession: MCSession!
    var mcAdvertiserAssistant: MCAdvertiserAssistant!
    var MCTestlabel = UILabel(frame: CGRect(x: 150, y: 600, width: 300, height: 40))


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get authorization to get user's location
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Sets map
        let coord = CLLocationCoordinate2D(latitude: gameLatitude, longitude: gameLongitude)
        mapView.camera = GMSCameraPosition(target: coord, zoom: Float(gameZoomLevel), bearing: 0, viewingAngle: 0)
        
        // Start of MC stuff
        startSessionButton.backgroundColor = UIColor.green
        startSessionButton.setTitle("Start Sesh", for: UIControlState())
        startSessionButton.addTarget(self, action: #selector(showConnectionPrompt), for: .touchUpInside)
        self.view.addSubview(startSessionButton)
        
        sendDataButton.backgroundColor = UIColor.green
        sendDataButton.setTitle("Send Data", for: UIControlState())
        sendDataButton.addTarget(self, action: #selector(sendData), for: .touchUpInside)
        self.view.addSubview(sendDataButton)
        
        
        MCTestlabel.textAlignment = NSTextAlignment.center
        MCTestlabel.adjustsFontSizeToFitWidth = true
        MCTestlabel.text = "tor"
        self.view.addSubview(MCTestlabel)
        title = "heis"
        
        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        //sendImage(data1: 4)

    }
    
    func showConnectionPrompt() {
        let ac = UIAlertController(title: "Connect to others", message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Host a session", style: .default, handler: startHosting))
        ac.addAction(UIAlertAction(title: "Join a session", style: .default, handler: joinSession))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    func sendData() {
        if mcSession.connectedPeers.count > 0 {
            var numVal: NSInteger = 6
            
            let data = NSData(bytes: &numVal, length: MemoryLayout<NSInteger>.size)
            
            do {
                try mcSession.send(data as Data, toPeers: mcSession.connectedPeers, with: .reliable)
                MCTestlabel.text?.append("1")
            } catch {
                let ac = UIAlertController(title: "Send error", message: error.localizedDescription, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(ac, animated: true)
                MCTestlabel.text?.append("2")
            }
        }
        
        
    }
    func startHosting(action: UIAlertAction!) {
        mcAdvertiserAssistant = MCAdvertiserAssistant(serviceType: "experimentation", discoveryInfo: nil, session: mcSession)
        mcAdvertiserAssistant.start()
    }
    
    func joinSession(action: UIAlertAction!) {
        let mcBrowser = MCBrowserViewController(serviceType: "experimentation", session: mcSession)
        mcBrowser.delegate = self
        present(mcBrowser, animated: true)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?) {
        
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connected: \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting: \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("Not Connected: \(peerID.displayName)")
        }
    }
    // CANT SEND WHEN NO CONNECTED PEERS!!
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        var val: NSInteger = 0
        //var data1 = NSData(bytes: &src, length: MemoryLayout<NSInteger>.size)
        var data1 = data as NSData
        data1.getBytes(&val, length: MemoryLayout<NSInteger>.size)
        // sent val should be 6, received val should be 5
        MCTestlabel.text?.append("from5CER\(val)")
    }

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse) {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            //mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
