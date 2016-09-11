//
//  MainMenuScene.swift
//  heis
//
//  Created by Ken Chen on 8/21/16.
//  Copyright © 2016 heis. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        /* Setup scene */
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let pos = touch.location(in: self)
            let node = self.atPoint(pos)
            
            /* Conditionals for which menu buttons were pressed */
        }
    }
}
