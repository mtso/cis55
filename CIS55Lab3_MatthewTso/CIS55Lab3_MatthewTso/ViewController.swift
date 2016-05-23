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
    let seaweedImage = UIImage(named: "seaweed")
    let seaweedImageNight = UIImage(named: "seaweed_night")
    
    let lapDuration = 10.0 //10.0
    let flipDuration = 2.0
    let greenfishImage = UIImage(named: "greenfish")
    let anglefishImage = UIImage(named: "anglefish")
    var hueFishImage: UIImage?
    var flippedImage: UIImage?
    var background: UIView?
    let rock = UIImageView(image: UIImage(named: "rock"))
//    var fishTank: UIView?
//    let pullCord = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 300))
    let pullCord = UIImageView(image: UIImage(named: "pullcord"))
    
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
    
    // xFromLeft:numberOfLeaves
//    let seaweedLocations = [4:6, 5:8, 10:11, 11:10]
    let seaweedLocations: [Int] = [-3, 1, 4, 5]
//    let seaweedLocations: [Int] = [4, 5, 10, 11]
    let seaweedHeights: [Int]   = [6, 8, 11, 10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        view.backgroundColor = UIColor(red: 0.1, green: 0.15, blue: 0.2, alpha: 1.0)
        view.backgroundColor = UIColor(red: 0.15, green: 0.25, blue: 0.3, alpha: 1.0)

//        fishTank = UIView(frame: view.frame)
//        fishTank!.backgroundColor = UIColor(red: 0.1, green: 0.15, blue: 0.2, alpha: 1.0)
        
//        view.addSubview(fishTank!)
        
        warningLabel.alpha = 0.0
        
        pullCord.tag = 3
        pullCord.frame = CGRect(x: pullCord.frame.origin.x, y: pullCord.frame.origin.y, width: pullCord.frame.width, height: view.frame.height * 3 / 4)
        pullCord.frame.origin = CGPoint(x: view.frame.width - pullCord.frame.width - 20, y: -40)
        pullCord.layer.transform = CATransform3DTranslate(CATransform3DIdentity, 0, 0, 200)
        
        background = UIView(frame: CGRect(x: 200, y: 120, width: 320, height: 300))
//        background!.frame = CGRect(x: 200, y: 120, width: 300, height: 300)
        
//        let seaweedHeight = 7
//        let seaweed = UIView(frame: CGRect(x: 0, y: 0, width: seaweedImage!.size.width, height: seaweedImage!.size.height * CGFloat(seaweedHeight)))
//        seaweed.tag = 4
//        
//        for seaweedNum in 0..<seaweedHeight {
//            let seaweedLeaf = UIImageView(image: seaweedImage)
////            seaweedLeaf.tag = 4
//            seaweedLeaf.frame.origin.y = seaweedLeaf.frame.height * CGFloat(seaweedNum)
//            seaweed.addSubview(seaweedLeaf)
//            spinSeaweed(seaweedLeaf, delay: 0.5 * Double(seaweedNum))
//        }
//        background!.insertSubview(seaweed, atIndex: 0)
        generateSeaweed()
//        background!.addSubview(seaweed)
        
        rock.frame = CGRect(x: 0, y: 0, width: 320, height: 300)
        
        rock.tag = 1
        //        rock.hidden = true
        
//        background!.addSubview(rock)
        background?.insertSubview(rock, atIndex: 0)
        background!.center = view.center
        background!.frame.origin.y = view.frame.height - background!.frame.height
        
        view.addSubview(background!)
        
        
        
//        pullCord.backgroundColor = UIColor.blackColor()
        view.addSubview(pullCord)
        
//        view.backgroundColor = UIColor(red: 0.1, green: 0.15, blue: 0.2, alpha: 1.0)
        print(view.frame)
        
//        flippedImage = UIImage(CGImage: greenfishImage!.CGImage!, scale: greenfishImage!.scale, orientation: .Left)
        
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
        
//        let firstFish = Fish(imageLeft: applyRandomHue(greenfishImage!), inFront: false, facingLeft: true)
////        newFish.frame = CGRect(x: 600, y: 120, width: 70, height: 40)
//        firstFish.frame = CGRect(x: view.frame.width + 100, y: 120, width: 70, height: 40)
//        firstFish.center = background!.center
//        firstFish.tag = 2
//        view.insertSubview(firstFish, belowSubview: background!)
//        swimLeft(firstFish)
//        
//        let secondFish = Fish(imageLeft: applyRandomHue(greenfishImage!), inFront: false, facingLeft: true)
//        secondFish.frame = CGRect(x: view.frame.width + 100, y: 120, width: 70, height: 40)
//        secondFish.center = background!.center
//        secondFish.tag = 2
//        view.insertSubview(secondFish, belowSubview: background!)
//        swimLeft(secondFish)
    }
    
    func generateSeaweed() {
//        let size = seaweedLocations.count
        
//        let UIImageView(image: seaweedImage)
        for number in 0..<seaweedLocations.count {
            let numberOfLeaves = seaweedHeights[number]
            let location = seaweedLocations[number]
            
            let seaweedHeight = CGFloat(numberOfLeaves) * seaweedImage!.size.height
            
            let seaweed = UIView(frame: CGRect(
                x: seaweedImage!.size.width * CGFloat(location), y: background!.frame.height - seaweedHeight,
//                x: seaweedImage!.size.width * CGFloat(location), y: view.frame.height - seaweedHeight,
                width: seaweedImage!.size.width, height: seaweedHeight))
            seaweed.tag = 4
//            seaweed.backgroundColor = UIColor.redColor()
            
            for leaf in 0..<numberOfLeaves {
                let seaweedLeaf = UIImageView(image: seaweedImage)
                //            seaweedLeaf.tag = 4
                seaweedLeaf.frame.origin.y = seaweedHeight - seaweedLeaf.frame.height - seaweedLeaf.frame.height * CGFloat(leaf)
                seaweed.addSubview(seaweedLeaf)
//                spinSeaweedLeaf(seaweedLeaf, delay: 0.5 * Double(leaf))
            }
            
            spinSeaweed(seaweed)
            
            background!.addSubview(seaweed)
        }
        
        
//        let seaweedHeight = 7
//        let seaweed = UIView(frame: CGRect(x: 0, y: 0, width: seaweedImage!.size.width, height: seaweedImage!.size.height * CGFloat(seaweedHeight)))
//        seaweed.tag = 4
//        
//        for seaweedNum in 0..<seaweedHeight {
//            let seaweedLeaf = UIImageView(image: seaweedImage)
//            //            seaweedLeaf.tag = 4
//            seaweedLeaf.frame.origin.y = seaweedLeaf.frame.height * CGFloat(seaweedNum)
//            seaweed.addSubview(seaweedLeaf)
//            spinSeaweed(seaweedLeaf, delay: 0.5 * Double(seaweedNum))
//        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func spinSeaweed(seaweed: UIView) {
//        for leaf in 0..<seaweed.subviews.count {
//            spinSeaweedLeaf(seaweed.subviews[leaf], delay: 0.4 * leaf)
//        }
        
        let initialDelay = Double(arc4random() % 200) / 10.0
        print(initialDelay)
        for subview in seaweed.subviews {
            let leaf = subview as! UIImageView
            let delayOfLeaf = Double(seaweed.subviews.indexOf(subview)!) * 0.4
            spinSeaweedLeaf(leaf, delay: initialDelay + delayOfLeaf)
        }
    }
    
    func spinSeaweedLeaf(seaweedLeaf: UIImageView, delay: Double) {
//        let initialDelay = random() % 4 + 4
        UIView.animateWithDuration(2.0, delay: delay, options: .CurveEaseInOut, animations: {
            seaweedLeaf.transform = CGAffineTransformMakeScale(0.2, 1)
            
            }, completion: { finished in
                self.expandSeaweed(seaweedLeaf)
        })
    }
    
    func collapseSeaweed(seaweedLeaf: UIImageView) {
//        let delay = Double(random() % 4 + 4)
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
                
//                fish.image = lightIsOn ? fish.darkImageLeft : fish.imageLeft
            }
        }
        for object in background!.subviews {
            if object.tag == 1 {
                let rock = object as! UIImageView
                rock.image = lightIsOn ? UIImage(named: "rock_night") : UIImage(named: "rock")
            } else if object.tag == 4 {
//                let seaweed = object as! UIView
                for subview in object.subviews {
                    let leaf = subview as! UIImageView
                    leaf.image = lightIsOn ? UIImage(named: "seaweed_night") : UIImage(named: "seaweed")
                }
            }
        }
        view.backgroundColor = lightIsOn ?
            UIColor(red: 0.05, green: 0.1, blue: 0.15, alpha: 1.0) :
//            UIColor(red: 0.1, green: 0.15, blue: 0.2, alpha: 1.0) :
            UIColor(red: 0.15, green: 0.25, blue: 0.3, alpha: 1.0)

        lightIsOn = lightIsOn ? false : true
        
//        if lightIsOn {
//            for subview in view.subviews {
//                if subview.tag == 2 {
//                    let fish = subview as! Fish
//                    fish.image = fish.darkImageLeft
//                }
//            }
//            
//            lightIsOn = false
//        } else {
//            for subview in view.subviews {
//                if subview.tag == 2 {
//                    let fish = subview as! Fish
//                    fish.image = fish.imageLeft
//                }
//            }
//            
//            lightIsOn = true
//        }
    }
    
    func viewTapped(recognizer: UITapGestureRecognizer) {
        
        shakeView()
        flashWarning()
        createFish()
        
//        for subview in view.subviews {
//            if subview.tag == 2 {
//                let fish = subview as! Fish
//                fish.image = fish.darkImageLeft
//            }
//        }
        
    }

    
    func applyRandomHue(source: UIImage) -> UIImage {
        let context = CIContext(options: nil)
        // Create an image to filter
        let inputImage = CIImage(image: source)
        // Create a random color to pass to a filter
        let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
        // Apply a filter to the image
        let filteredImage = inputImage!.imageByApplyingFilter("CIHueAdjust", withInputParameters: randomColor)
        // Render the filtered image
        let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent)
        // Return a UIImage
        return UIImage(CGImage: renderedImage)
    }
    
    func huedImageWithImage(source: UIImage, rotatedByHue: CGFloat) -> UIImage {
        // Create a Core Image version of the image.
        let sourceCore = CIImage(CGImage: source.CGImage!)
        // Apply a CIHueAdjust filter
        let hueAdjust = CIFilter(name: "CIHueAdjust")
        hueAdjust!.setDefaults()
        hueAdjust!.setValue(sourceCore, forKey: "inputImage")
        hueAdjust!.setValue(CGFloat(rotatedByHue), forKey: "inputAngle")
        let resultCore  = hueAdjust!.valueForKey("outputImage") as! CIImage
        let context = CIContext(options: nil)
        let resultRef = context.createCGImage(resultCore, fromRect: resultCore.extent)
        let result = UIImage(CGImage: resultRef)
        return result
    }
    
    func swimLeft(fish: Fish) {
        let randomX = CGFloat(arc4random()) % view.frame.width / 6 + view.frame.width / 12
        let randomY = CGFloat(arc4random()) % (view.frame.height * 0.8) + (view.frame.height * 0.1)
        
        let randomDuration = lapDuration + Double(arc4random() % 3)
        
        UIView.animateWithDuration(randomDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.center = CGPoint(x: randomX, y: randomY)
//            fish.center.x = 100 // -= 500
            }, completion: { finished in
                self.flipImageAnimation(fish)
//                self.toggleFrontBack(fish)
//                self.swimRight(fish)
        })

    }
    
    func swimRight(fish: Fish) {
        let randomDuration = lapDuration + Double(arc4random() % 3)

        let randomX = view.frame.width - CGFloat(arc4random()) % view.frame.width / 6 - view.frame.width * 1 / 12   // + view.frame.width / 20
//        let randomX = CGFloat(random()) % view.frame.width - view.frame.width / 20
        let randomY = CGFloat(random()) % (view.frame.height * 0.8) + (view.frame.height * 0.1)
        
        UIView.animateWithDuration(randomDuration, delay: 0.0, options: .CurveLinear, animations: {
//            fish.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0)

            fish.center = CGPoint(x: randomX, y: randomY)
//            fish.center.x = 600 // -= 500
            }, completion: { finished in
                self.flipImageAnimation(fish)
//                self.toggleFrontBack(fish)
//                self.flipImage(fish)
//                self.swimLeft(fish)
        })
//        fish.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI),0.0, -0.5 ,0.0)

    }
    
    func toggleFrontBack(fish: Fish) {
        let toggleChance = arc4random() % 3
        
//        print(fish.layer.transform)

        
        if toggleChance == 0 {
//            fish.layer.transform = CATransform3DMakeTranslation(0, 0, -1)
//            fish.layer.transform = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0)
            
            let translation = CATransform3DMakeTranslation(0, 0, -1)
            let rotation = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0)
            let combined = CATransform3DConcat(translation, rotation)
            
            fish.layer.transform = combined

            fish.inFront = false
        } else {

//            fish.layer.transform = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0)
//            fish.layer.transform = CATransform3DMakeTranslation(0, 0, 1)
            
            let translation = CATransform3DMakeTranslation(0, 0, 1)
            let rotation = fish.facingLeft ? CATransform3DMakeRotation(CGFloat(M_PI),0.0, 0.0 ,0.0) : CATransform3DMakeRotation(CGFloat(M_PI),0.0, 1.0 ,0.0)

            let combined = CATransform3DConcat(translation, rotation)
            
            fish.layer.transform = combined
            
            fish.inFront = true
        }
//        print(fish.layer.transform)


    }
    
    func flipImageAnimation(fish: Fish) {
        let matrixValue: CGFloat = fish.facingLeft ? 1.0 : 0.0
//        let matrixValue: CGFloat = fish.facingLeft ? 1.0 : 0.0
        fish.facingLeft = fish.facingLeft ? false : true
        let flipDistance:CGFloat = 40
        
        UIView.animateWithDuration(flipDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI),0.0, matrixValue ,0.0)
//            
//            let scale = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0)
//            let rotate = CATransform3DMakeRotation(CGFloat(M_PI),0.0, matrixValue ,0.0)
//            let combined = CATransform3DConcat(scale, rotate)
//            
//            fish.layer.transform = combined
            
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
    
    func shakeView() {
//        let intensity = 3
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
        
//        for subview in view.subviews {
//            subview.layer.addAnimation( anim, forKey:nil )
//
//        }
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

//            let newFish = Fish(imageLeft: newfishImage, inFront: false, facingLeft: true)
//            newFish.frame = CGRect(x: view.frame.width + 100, y: 120, width: 70, height: 40)
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
    
}

