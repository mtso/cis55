//
//  ViewController.swift
//  SwimmingFishTest
//
//  Created by Matthew Tso on 5/20/16.
//  Copyright © 2016 De Anza. All rights reserved.
//
//define DegreesToRadians(x) ((x) * M_PI / 180.0)

import UIKit

class ViewController: UIViewController {
    
    var facingLeft = true
//    let headImage = UIImage(named: "head")
//    let tailImage = UIImage(named: "tail")
//    let headImageNight = UIImage(named: "head_night")
//    let tailImageNight = UIImage(named: "tail_night")
    
    let headImage = UIImage(named: "head_anglefish")
    let tailImage = UIImage(named: "tail_anglefish")
    let headImageNight = UIImage(named: "head_anglefish_night")
    let tailImageNight = UIImage(named: "tail_anglefish_night")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        view.backgroundColor = UIColor.blackColor()
        
        let fish = Fish(origin: CGPoint(x: view.frame.width - 150, y: 20), isAnglefish: true,
            headImage: headImage!, tailImage: tailImage!,
            headImageNight: headImageNight!, tailImageNight: tailImageNight!)
        
        fish.tag = 2
        view.addSubview(fish)
        
        swimLeft(fish)
    }
    
    func swimLeft(fish: UIView) {
        let randomX = CGFloat(random()) % view.frame.width / 6 + view.frame.width / 12
        let randomY = CGFloat(random()) % (view.frame.height * 0.8) + (view.frame.height * 0.1)
        
        let randomDuration = 10 + Double(random() % 3)
        
        UIView.animateWithDuration(randomDuration, delay: 0.0, options: .CurveLinear, animations: {
            fish.center = CGPoint(x: randomX, y: randomY)
            //            fish.center.x = 100 // -= 500
            }, completion: { finished in
                self.flipImageAnimation(fish)
                //                self.toggleFrontBack(fish)
                //                self.swimRight(fish)
        })
        
    }
    
    func flipImageAnimation(fish: UIView) {
        let matrixValue: CGFloat = facingLeft ? 1.0 : 0.0
//        facingLeft = facingLeft ? false : true
        let flipDistance:CGFloat = -40
        
        UIView.animateWithDuration(2, delay: 0.0, options: .CurveLinear, animations: {
            fish.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI),0.0, matrixValue ,0.0)
            }, completion: { finished in
//                fish.facingLeft ? self.swimLeft(fish) : self.swimRight(fish)
//                self.toggleFrontBack(fish)
        })
        UIView.animateWithDuration(2 / 2, delay: 0.0, options: .CurveLinear, animations: {
            fish.center.x += self.facingLeft ? flipDistance : -flipDistance
            }, completion: nil)
        UIView.animateWithDuration(2 / 2, delay: 2 / 2, options: .CurveLinear, animations: {
            fish.center.x += self.facingLeft ? -flipDistance : flipDistance
            }, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func toggleLightClick(sender: AnyObject) {
        let newFish = Fish(origin: view.center, isAnglefish: true, headImage: headImage!, tailImage: tailImage!, headImageNight: headImageNight!, tailImageNight: tailImageNight!)
        newFish.tag = 2
        swimLeft(newFish)
        view.addSubview(newFish)
        
        for subview in view.subviews {
            if subview.tag == 2 {
                let fish = subview as! Fish
                
                fish.toggleLight()
            }
        }
    }

}

