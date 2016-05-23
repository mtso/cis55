//
//  GameScene.swift
//  CropNodeAnimation
//
//  Created by Matthew Tso on 5/23/16.
//  Copyright (c) 2016 De Anza. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var mask: SKShapeNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        let node = SKCropNode()
        node.position = view.center
        
        mask = SKShapeNode(circleOfRadius: 40.0)
        node.maskNode = mask
        
        let box = SKShapeNode(rectOfSize: CGSize(width: 150.0, height: 150.0))
        
        box.fillColor = SKColor.whiteColor()
        box.position = CGPointZero
        
        node.addChild(box)
        addChild(node)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            mask?.runAction(SKAction.moveBy(CGVector(dx: 0, dy: 10), duration: 0.5))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
