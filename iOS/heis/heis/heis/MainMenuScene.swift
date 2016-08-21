//
//  MainMenuScene.swift
//  heis
//
//  Created by Ken Chen on 8/21/16.
//  Copyright © 2016 heis. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMoveToView(view: SKView) {
        /* Setup scene */
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.locationInNode(self)
            let node = self.nodeAtPoint(pos)
            
            /* Conditionals for which menu buttons were pressed */
        }
    }
}