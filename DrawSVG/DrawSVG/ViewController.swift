//
//  ViewController.swift
//  DrawSVG
//
//  Created by Matthew Tso on 4/27/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import PocketSVGFramework

class ViewController: UIViewController {

    var pathLayer: CAShapeLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let CGPath = PocketSVG.pathFromSVGFileNamed("lumpy_squares").takeUnretainedValue()

        pathLayer = CAShapeLayer()
        pathLayer.path = CGPath
        pathLayer.fillColor = nil
        pathLayer.strokeColor = UIColor.blackColor().CGColor
        pathLayer.lineWidth = 1
                
        view.layer.addSublayer(pathLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    @IBAction func beginAnimation(sender: AnyObject) {
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 1
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        pathLayer.addAnimation(pathAnimation, forKey: "strokeAnimation")
    }

}

