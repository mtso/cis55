//
//  GameScene.swift
//  PenguinJump
//
//  Created by Matthew Tso on 5/13/16.
//  Copyright (c) 2016 De Anza. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let penguin = SKSpriteNode(imageNamed: "player")
    var penguinShadow: SKShapeNode?
    var stage : SKSpriteNode?
    var yIncrement : CGFloat?
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        // Set constants based on scene size
        yIncrement = size.height / 5
        
        // Create penguin
        penguin.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        let playerBody = SKPhysicsBody(rectangleOfSize: penguin.frame.size)
        playerBody.mass = 0
        playerBody.dynamic = true
//        penguin.physicsBody = playerBody
        addChild(penguin)
        
        // Create penguin's shadow
        penguinShadow = SKShapeNode(rectOfSize: CGSize(width: penguin.frame.width, height: penguin.frame.width), cornerRadius: penguin.frame.width / 2)
        penguinShadow!.fillColor = SKColor.blackColor()
        penguinShadow!.alpha = 0.2
        penguinShadow!.position = CGPoint(x: 0, y: -penguinShadow!.frame.height/4)// -penguin.frame.width/4) // -penguin.frame.height + penguin.frame.width * 1.25 )
        let shadowBody = SKPhysicsBody(circleOfRadius: penguinShadow!.frame.size.height * 0.5)
        shadowBody.dynamic = true
        penguinShadow!.physicsBody = shadowBody
        penguin.addChild(penguinShadow!)
        
        // Create stage
        let stageNode = SKSpriteNode(color: UIColor.clearColor(), size: CGSize(width: size.width, height: size.height))
        stage = stageNode
        stage!.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(stage!)
        
        generateBergs()
        
        physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        
    }
    
    func generateBergs() {
        for bergIndex in 0...3 {
            // Create an iceberg
            let berg = SKShapeNode(rectOfSize: CGSize(width: penguin.frame.height * 3, height: penguin.frame.height * 3))
            berg.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.1)
            berg.position = self.convertPoint(CGPoint(x: size.width * 0.5, y: yIncrement! * CGFloat(bergIndex) + penguin.position.y), toNode: stage!)
            
            let bergBody = SKPhysicsBody(rectangleOfSize: berg.frame.size)
            bergBody.dynamic = true
            
            stage?.addChild(berg)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        jump()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {

        for touch: AnyObject in touches {
            let positionInScene = touch.locationInNode(self)
            let previousPosition = touch.previousLocationInNode(self)
            let translation = CGPoint(x: positionInScene.x - previousPosition.x, y: positionInScene.y - previousPosition.y)
            
            for berg in stage!.children {
                berg.position = CGPoint(x: berg.position.x + translation.x, y: berg.position.y + translation.y)
            }
        }
        
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    }
    
    override func update(currentTime: NSTimeInterval) {
//        onIceberg()
    }
    
    func onIceberg() -> Bool {
        var onBerg = false
        for berg in stage!.children {
            if penguinShadow!.intersectsNode(berg) {
                onBerg = true
            }
        }
        return onBerg
    }
    
    func jump() {
        let jumpHeight = yIncrement! * 0.5
        let jumpDuration = 1.0
        
        let jumpAction = SKAction.moveBy(CGVector(dx: 0.0, dy: jumpHeight), duration: NSTimeInterval(jumpDuration * 0.5))
        let fallAction = SKAction.moveBy(CGVector(dx: 0.0, dy: -jumpHeight), duration: NSTimeInterval(jumpDuration * 0.5))
        
        let jumpSequence = SKAction.sequence([jumpAction, fallAction])
        let counterSequence = SKAction.sequence([fallAction, jumpAction])
        
        penguin.runAction(jumpSequence, completion: { () -> Void in
            self.onIceberg()
        })
        penguinShadow?.runAction(counterSequence)
    }
}
