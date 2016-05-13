//
//  GameScene.swift
//  SpriteKitSimpleGame
//
//  Created by Matthew Tso on 5/12/16.
//  Copyright (c) 2016 De Anza. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let penguin = SKSpriteNode(imageNamed: "player")
    
    override func didMoveToView(view: SKView) {
        backgroundColor = SKColor.whiteColor()
        
        penguin.position = CGPoint(x: size.width * 0.5, y: size.height * 0.9)
        print(penguin.position)
        let playerBody = SKPhysicsBody(rectangleOfSize: penguin.frame.size)
        playerBody.mass = 0
        playerBody.dynamic = false
        penguin.physicsBody = playerBody
        
        let testBerg = SKShapeNode(rectOfSize: CGSize(width: penguin.frame.height * 3, height: penguin.frame.height * 3))
        testBerg.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        testBerg.strokeColor = SKColor.greenColor()
        testBerg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.1)
        let bergBody = SKPhysicsBody(rectangleOfSize: testBerg.frame.size)
//        bergBody.dy
        
        addChild(testBerg)
        addChild(penguin)
    }
    
    func initializeStage() {
        let iceberg = SKShapeNode(rectOfSize: CGSize(width: penguin.frame.height * 3, height: penguin.frame.height * 3))
        
        
    }
    
    func addIceberg(yPosition: CGFloat) {
        
    }
}
