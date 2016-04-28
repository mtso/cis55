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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let floorPlanCGPath = PocketSVG.pathFromSVGFileNamed("floorplan").takeUnretainedValue()
        
        let floorPlanPath = UIBezierPath(CGPath: floorPlanCGPath)
        
        UIGraphicsBeginImageContext(CGSize(width: floorPlanPath.bounds.width, height: floorPlanPath.bounds.height))
        
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        CGContextSetFillColorWithColor(context, UIColor.lightGrayColor().CGColor)
        
        floorPlanPath.fill()
        floorPlanPath.stroke()
        
        let bezierImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let imageView = UIImageView(image: bezierImage)
        
        view.addSubview(imageView)
     
//        let floorPlanShapeLayer = CAShapeLayer()
//        
//        floorPlanShapeLayer.path = floorPlanPath
//        
//        floorPlanShapeLayer.strokeColor = UIColor.redColor().CGColor
//        floorPlanShapeLayer.lineWidth = 1
//        floorPlanShapeLayer.fillColor = UIColor.lightGrayColor().CGColor
        
//        let shapeCenter = floorPlanShapeLayer.frame.width / 2
        
//        floorPlanShapeLayer.frame.origin = CGPoint(x: view.center.x - floorPlanShapeLayer.frame.width, y: view.center.y - floorPlanShapeLayer.frame.width)
        
//        floorPlanShapeLayer.frame.origin = CGPoint(x: floorPlanShapeLayer.bounds.width, y: floorPlanShapeLayer.bounds.width)
//        
//        print(view.center)
        
//        view.layer.addSublayer(floorPlanShapeLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

