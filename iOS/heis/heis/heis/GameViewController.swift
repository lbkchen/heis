//
//  GameViewController.swift
//  heis
//
//  Created by Ken Chen on 8/21/16.
//  Copyright (c) 2016 heis. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMaps


class GameViewController: UIViewController, CLLocationManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let skView = view as! SKView
        
        let scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.size = skView.bounds.size

        skView.isMultipleTouchEnabled = false
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
