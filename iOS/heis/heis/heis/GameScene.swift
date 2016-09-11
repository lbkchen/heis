//
//  GameScene.swift
//  heis
//
//  Created by Ken Chen on 8/21/16.
//  Copyright (c) 2016 heis. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        // Default anchorPoint is actually just this
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let background = SKSpriteNode(imageNamed: "background")
        // Same as above default anchorpoint is just 0.5, 0.5
        // See this guide for further reference on anchor points: 
        // http://www.garethelms.org/2014/06/help-with-spritekit-position-and-anchorpoint/
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        addChild(background)
        
        // Create title
        let title = SKSpriteNode(imageNamed: "logo")
        title.position = CGPoint(x: 0, y: 160)
        background.addChild(title)
        
        // Create menu buttons
        let menuLayer = SKNode()
        menuLayer.position = CGPoint(x: 0, y: -60)
        background.addChild(menuLayer)
        displayMenuButtons(menuLayer, spacing: CGFloat(10.0))
    }
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
//        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
//        myLabel.text = "Hello, World!"
//        myLabel.fontSize = 45
//        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
//        
//        self.addChild(myLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self)
            
            let sprite = SKSpriteNode(imageNamed:"menu_buttons_help")
            
            sprite.xScale = 0.5
            sprite.yScale = 0.5
            sprite.position = location
            
            let action = SKAction.rotate(byAngle: CGFloat(M_PI), duration:1)
            
            sprite.run(SKAction.repeatForever(action))
            
            self.addChild(sprite)
        }
    }
   
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func displayMenuButtons(_ layer: SKNode, spacing: CGFloat) {
        let buttonOne = SKSpriteNode(imageNamed: "menu_buttons_create_game")
        let buttonTwo = SKSpriteNode(imageNamed: "menu_buttons_join_game")
        let buttonThree = SKSpriteNode(imageNamed: "menu_buttons_help")
        let buttonHeight = buttonTwo.size.height
        buttonOne.position = CGPoint(x: 0, y: buttonHeight + spacing)
        buttonThree.position = CGPoint(x: 0, y: -1 * (buttonHeight + spacing))
        buttonOne.alpha = 0
        buttonTwo.alpha = 0
        buttonThree.alpha = 0
        
        layer.addChild(buttonOne)
        layer.addChild(buttonTwo)
        layer.addChild(buttonThree)
        for button in [buttonOne, buttonTwo, buttonThree] {
            button.run(easeInDown(button, distance: 10, duration: 0.2))
            print("run")
        }
    }
    
    func easeInDown(_ node: SKNode, distance: CGFloat, duration: CGFloat) -> SKAction {
        let destPoint = CGPoint(x: node.position.x, y: node.position.y - distance)
        let moveAction = SKAction.move(to: destPoint, duration: TimeInterval(duration))
        let fadeAction = SKAction.fadeAlpha(to: 1.0, duration: TimeInterval(duration))
        return SKAction.group([moveAction, fadeAction])
    }
}
