//
//  ViewController.swift
//  CIS55Lab3_MatthewTso
//
//  Created by Matthew Tso on 5/17/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

/*
tags:
1: rock
2: fish
3: pullcord
4: seaweed
*/

class ViewController: UIViewController {
    
    @IBOutlet var warningLabel: UILabel!
    let lapDuration = 10.0 //10.0
    let flipDuration = 2.0

    var background: UIView?
    let rock = UIImageView(image: UIImage(named: "rock"))
    let pullCord = UIImageView(image: UIImage(named: "pullcord"))
    let seaweedImage = UIImage(named: "seaweed")
    let seaweedImageNight = UIImage(named: "seaweed_night")
    
    let headImage = UIImage(named: "head")
    let tailImage = UIImage(named: "tail")
    let headImageNight = UIImage(named: "head_night")
    let tailImageNight = UIImage(named: "tail_night")

    let headAnglefishImage = UIImage(named: "head_anglefish")
    let tailAnglefishImage = UIImage(named: "tail_anglefish")
    let headAnglefishImageNight = UIImage(named: "head_anglefish_night")
    let tailAnglefishImageNight = UIImage(named: "tail_anglefish_night")
    
    var inFront = false
    var facingLeft = true
    var lightIsOn = true
    
    let seaweedLocations: [Int] = [-3, -2, 9, 11, 28, 30]
    let seaweedHeights: [Int]   = [3, 6, 5, 8, 6, 4]
    
    let seaweedBehindLocations: [Int] = [4, 6, 22, 23]
    let seaweedBehindHeights: [Int]   = [11, 10, 9, 10]
    
    var bubbleTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        view.backgroundColor = UIColor(red: 0.15, green: 0.25, blue: 0.3, alpha: 1.0)
        warningLabel.alpha = 0.0
        
        pullCord.tag = 3
        pullCord.frame = CGRect(x: pullCord.frame.origin.x, y: pullCord.frame.origin.y, width: pullCord.frame.width, height: view.frame.height * 3 / 4)
        pullCord.frame.origin = CGPoint(x: view.frame.width - pullCord.frame.width - 20, y: -40)
        pullCord.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 200)
        
        background = UIView(frame: CGRect(x: 200, y: 120, width: 320, height: 300))
        background!.center = view.center
        background!.frame.origin.y = view.frame.height - background!.frame.height
        
        generateSeaweed()
        
        rock.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        rock.tag = 1
        background!.insertSubview(rock, atIndex: 0)
        
        view.addSubview(background!)
        view.addSubview(pullCord)
        
        let viewTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "viewTapped:")
        viewTap.numberOfTapsRequired = 1
        viewTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(viewTap)
        view.userInteractionEnabled = true
        
        let cordTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "cordTapped:")
        cordTap.numberOfTapsRequired = 1
        cordTap.numberOfTouchesRequired = 1
        pullCord.addGestureRecognizer(cordTap)
        pullCord.userInteractionEnabled = true

        let firstFish = Fish(origin: background!.center, isAnglefish: false, inFront: false, facingLeft: true,
            headImage: headImage!, tailImage: tailImage!, headImageNight: headImageNight!, tailImageNight: tailImageNight!)
        firstFish.center = background!.center
        firstFish.tag = 2
        lightIsOn ? firstFish.lightOn() : firstFish.lightOff()
        view.insertSubview(firstFish, belowSubview: background!)
        swimLeft(firstFish)
        
        let secondFish = Fish(origin: background!.center, isAnglefish: false, inFront: false, facingLeft: true,
            headImage: headImage!, tailImage: tailImage!, headImageNight: headImageNight!, tailImageNight: tailImageNight!)
        secondFish.center = background!.center
        secondFish.tag = 2
        lightIsOn ? secondFish.lightOn() : secondFish.lightOff()
        view.insertSubview(secondFish, belowSubview: background!)
        swimLeft(secondFish)
        
        // Create a chance to generate bubbles every second
        bubbleTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "generateBubbles", userInfo: nil, repeats: true)
        
        toggleLights()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Generator methods for seaweed and bubbles.
    
    func generateSeaweed() {

        for number in 0..<seaweedLocations.count {
            let numberOfLeaves = seaweedHeights[number]
            let location = seaweedLocations[number]
            
            let seaweedHeight = CGFloat(numberOfLeaves) * seaweedImage!.size.height
            
            let seaweed = UIView(frame: CGRect(
                x: seaweedImage!.size.width * CGFloat(location), y: background!.frame.height - seaweedHeight,
                width: seaweedImage!.size.width, height: seaweedHeight))
            seaweed.tag = 4
            
            for leaf in 0..<numberOfLeaves {
                let seaweedLeaf = UIImageView(image: seaweedImage)
                seaweedLeaf.frame.origin.y = seaweedHeight - seaweedLeaf.frame.height - seaweedLeaf.frame.height * CGFloat(leaf)
                seaweed.addSubview(seaweedLeaf)
            }
            
            spinSeaweed(seaweed)
            
            background!.addSubview(seaweed)
        }
        
        for number in 0..<seaweedBehindLocations.count {
            let numberOfLeaves = seaweedBehindHeights[number]
            let location = seaweedBehindLocations[number]
            
            let seaweedHeight = CGFloat(numberOfLeaves) * seaweedImage!.size.height
            
            let seaweed = UIView(frame: CGRect(
                x: seaweedImage!.size.width * CGFloat(location), y: background!.frame.height - seaweedHeight,
                width: seaweedImage!.size.width, height: seaweedHeight))
            seaweed.layer.transform = CATransform3DMakeTranslation(0, 0, -100)
            seaweed.tag = 4
            
            for leaf in 0..<numberOfLeaves {
                let seaweedLeaf = UIImageView(image: seaweedImage)
                seaweedLeaf.frame.origin.y = seaweedHeight - seaweedLeaf.frame.height - seaweedLeaf.frame.height * CGFloat(leaf)
                seaweed.addSubview(seaweedLeaf)
            }
            
            spinSeaweed(seaweed)
            
            background!.insertSubview(seaweed, belowSubview: rock)
        }
        
    }
    
    func generateBubbles() {
        let randomNumber = random() % 5
        if randomNumber == 0 {
            let bubbleCount = random() % 10 + 5
            let bubbleSize:CGFloat = 6.0
            
            let xPosition = random() % Int(view.frame.width)
            
            for count in 0..<bubbleCount{
                let bubble = UIView(frame: CGRect(x: CGFloat(xPosition), y: view.frame.height - bubbleSize * CGFloat(count) + bubbleSize * CGFloat(bubbleCount),
                    width: bubbleSize, height: bubbleSize) )
                bubble.backgroundColor = UIColor.whiteColor()
                bubble.alpha = 0.07
                bubble.layer.cornerRadius = bubbleSize / 2
                bubble.layer.transform = CATransform3DMakeTranslation(0, 0, -1000)
                view.addSubview(bubble)
                animateBubble(bubble)
            }
        }
        bubbleTimer.invalidate()
        
        bubbleTimer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "generateBubbles", userInfo: nil, repeats: true)
    }
    
    func animateBubble(bubble: UIView) {
        if bubble.frame.origin.y < -50 {
            bubble.removeFromSuperview()
        } else {
            UIView.animateWithDuration(0.0, delay: 0.05, options: .CurveLinear, animations: {
                bubble.frame.origin.y -= bubble.frame.height
                }, completion: { finished in
                    self.animateBubble(bubble)
            })
        }
    }
    
    // MARK: Seaweed animation methods
    func spinSeaweed(seaweed: UIView) {
        let initialDelay = Double(arc4random() % 200) / 10.0
        for subview in seaweed.subviews {
            let leaf = subview as! UIImageView
            let delayOfLeaf = Double(seaweed.subviews.indexOf(subview)!) * 0.4
            spinSeaweedLeaf(leaf, delay: initialDelay + delayOfLeaf)
        }
    }
    
    func spinSeaweedLeaf(seaweedLeaf: UIImageView, delay: Double) {
        UIView.animateWithDuration(2.0, delay: delay, options: .CurveEaseInOut, animations: {
            seaweedLeaf.transform = CGAffineTransformMakeScale(0.2, 1)
            
            }, completion: { finished in
                self.expandSeaweed(seaweedLeaf)
        })
    }
    
    func collapseSeaweed(seaweedLeaf: UIImageView) {
        UIView.animateWithDuration(2.0, delay: 5.0, options: .CurveEaseInOut, animations: {
            seaweedLeaf.transform = CGAffineTransformMakeScale(0.2, 1)

            }, completion: { finished in
                self.expandSeaweed(seaweedLeaf)
        })
    }
    
    func expandSeaweed(seaweedLeaf: UIImageView) {
        UIView.animateWithDuration(2.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            seaweedLeaf.transform = CGAffineTransformMakeScale(1, 1)
            
            }, completion: { finished in
                self.collapseSeaweed(seaweedLeaf)
        })
    }
    
    // MARK: Tap gesture methods

    func cordTapped(recognizer: UITapGestureRecognizer) {
        UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseOut, animations: {
            self.pullCord.frame.origin.y = 0
            }, completion: { finished in
                self.toggleLights()
                
                UIView.animateWithDuration(0.4, delay: 0.0, options: .CurveEaseIn,
                    animations: { self.pullCord.frame.origin.y = -40 }, completion: nil)
        })
    }
    
    func toggleLights() {
        for subview in view.subviews {
            if subview.tag == 2 {
                let fish = subview as! Fish
                
                lightIsOn ? fish.lightOff() : fish.lightOn()
            }
        }
        for object in background!.subviews {
            if object.tag == 1 {
                let rock = object as! UIImageView
                rock.image = lightIsOn ? UIImage(named: "rock_night") : UIImage(named: "rock")
            } else if object.tag == 4 {
                for subview in object.subviews {
                    let leaf = subview as! UIImageView
                    leaf.image = lightIsOn ? UIImage(named: "seaweed_night") : UIImage(named: "seaweed")
                }
            }
        }
        view.backgroundColor = lightIsOn ?
            UIColor(red: 0.05, green: 0.1, blue: 0.15, alpha: 1.0) :
            UIColor(red: 0.15, green: 0.25, blue: 0.3, alpha: 1.0)

        lightIsOn = lightIsOn ? false : true
    }
    
    func viewTapped(recognizer: UITapGestureRecognizer) {
        shakeView()
        flashWarning()
        createFish()
    }
    
    func shakeView() {
        let anim = CAKeyframeAnimation( keyPath:"transform" )
        let intensity: CGFloat = 5.0
        anim.values = [
            NSValue( CATransform3D:CATransform3DMakeTranslation(-intensity, 0, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 0, intensity, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation(-intensity, 0, 0 ) ),
            NSValue( CATransform3D:CATransform3DMakeTranslation( 0, -intensity, 0 ) )
        ]
        anim.autoreverses = true
        anim.repeatCount = 2
        anim.duration = 4/100
        
        view.layer.addAnimation( anim, forKey:nil )
    }
    
    func createFish() {
        let chance = arc4random() % 4
        
        if chance == 0 {
            let anglefishChance = arc4random() % 4
            
            let isAnglefish = anglefishChance == 0 ? true : false
            
            let newFish = Fish(
                origin: background!.center, isAnglefish: isAnglefish, inFront: false, facingLeft: true,
                headImage: isAnglefish ? headAnglefishImage! : headImage!,
                tailImage: isAnglefish ? tailAnglefishImage! : tailImage!,
                headImageNight: isAnglefish ? headAnglefishImageNight! : headImageNight!,
                tailImageNight: isAnglefish ? tailAnglefishImageNight! : tailImageNight!)
            
            lightIsOn ? newFish.lightOn() : newFish.lightOff()
            
            newFish.tag = 2
            newFish.center = background!.center
            view.insertSubview(newFish, belowSubview: background!)
            swimLeft(newFish)
            
        }
        
    }
    
    func flashWarning() {
        view.insertSubview(warningLabel, atIndex: view.subviews.count)
        warningLabel.alpha = 1.0
        UIView.animateWithDuration(1.0, delay: 1.0, options: .CurveEaseOut, animations: {
            self.warningLabel.alpha = 0.0
            }, completion: nil)
    }
    
    // MARK: Fish animation methods
    func swimLeft(fish: Fish) {
        let randomX = CGFloat(arc4random()) % view.frame.width / 6 + view.frame.width / 12
        let randomY = CGFloat(arc4random()) % (view.frame.height * 0.8) + (view.frame.height * 0.1)
        
        let randomDuration = lapDuration + Double(arc4random() % 3)
        
        UIView.animateWithDuration(randomDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.center = CGPoint(x: randomX, y: randomY)
            }, completion: { finished in
                self.flipImageAnimation(fish)
        })

    }
    
    func swimRight(fish: Fish) {
        let randomDuration = lapDuration + Double(arc4random() % 3)

        let randomX = view.frame.width - CGFloat(arc4random()) % view.frame.width / 6 - view.frame.width * 1 / 12   // + view.frame.width / 20
        let randomY = CGFloat(random()) % (view.frame.height * 0.8) + (view.frame.height * 0.1)
        
        UIView.animateWithDuration(randomDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.center = CGPoint(x: randomX, y: randomY)
            }, completion: { finished in
                self.flipImageAnimation(fish)
        })
    }
    
    func toggleFrontBack(fish: Fish) {
        let toggleChance = arc4random() % 3
        
        if toggleChance == 0 {
            let translation = CATransform3DMakeTranslation(0, 0, -1)
            let rotation = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0)
            let combined = CATransform3DConcat(translation, rotation)
            
            fish.layer.transform = combined

            fish.inFront = false
        } else {
            let translation = CATransform3DMakeTranslation(0, 0, 1)
            let rotation = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0)

            let combined = CATransform3DConcat(translation, rotation)
            
            fish.layer.transform = combined
            
            fish.inFront = true
        }
    }
    
    func flipImageAnimation(fish: Fish) {
        let matrixValue: CGFloat = fish.facingLeft ? 1.0 : 0.0
        fish.facingLeft = fish.facingLeft ? false : true
        let flipDistance:CGFloat = 40
        
        UIView.animateWithDuration(flipDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI),0.0, matrixValue ,0.0)
            }, completion: { finished in
                fish.facingLeft ? self.swimLeft(fish) : self.swimRight(fish)
                self.toggleFrontBack(fish)
        })
        UIView.animateWithDuration(flipDuration / 2, delay: 0.0, options: .CurveLinear, animations: {
            fish.center.x += fish.facingLeft ? flipDistance : -flipDistance
            }, completion: nil)
        UIView.animateWithDuration(flipDuration / 2, delay: flipDuration / 2, options: .CurveLinear, animations: {
            fish.center.x += fish.facingLeft ? -flipDistance : flipDistance
            }, completion: nil)
    }
    
    
}