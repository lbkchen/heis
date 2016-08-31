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
        scene.scaleMode = .AspectFill
        scene.size = skView.bounds.size

        skView.multipleTouchEnabled = false
        skView.showsFPS = true
        skView.showsNodeCount = true
//        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
