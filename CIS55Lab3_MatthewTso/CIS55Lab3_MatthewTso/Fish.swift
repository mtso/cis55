//
//  Fish.swift
//  CIS55Lab3_MatthewTso
//
//  Created by Matthew Tso on 5/20/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class Fish: UIView {
    var facingLeft = true
    var inFront = false
    var isAnglefish: Bool?
    
    var headImage: UIImage?
    var tailImage: UIImage?
    var headImageNight: UIImage?
    var tailImageNight: UIImage?
    
    var head: UIImageView?
    var tail: UIImageView?
    
    init(origin: CGPoint, isAnglefish: Bool, inFront: Bool, facingLeft: Bool,
        headImage: UIImage, tailImage: UIImage, headImageNight: UIImage, tailImageNight: UIImage) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: headImage.size.width + tailImage.size.width, height: headImage.size.height))
        
        self.facingLeft = facingLeft
        self.inFront = inFront
        //        let randomColor = (Double(arc4random_uniform(314)) / 100)
        
        //        self.headImage = headImage
        //        self.tailImage = tailImage
        //        self.headImageNight = headImageNight
        //        self.tailImageNight = tailImageNight
        
//        let randomColor = (Double(arc4random_uniform(314)) / 100)
        let randomColor = (Double(arc4random_uniform(628)) / 100)
        self.headImage = applyHue(headImage, color: randomColor)
        self.tailImage = applyHue(tailImage, color: randomColor)
        self.headImageNight = applyHue(headImageNight, color: randomColor)
        self.tailImageNight = applyHue(tailImageNight, color: randomColor)
        
        self.head = UIImageView(image: self.headImage)
        self.tail = UIImageView(image: self.tailImage)
        
        
        head!.frame = CGRect(x: head!.frame.origin.x, y: head!.frame.origin.y, width: headImage.size.width, height: headImage.size.height)
        tail!.frame = CGRect(x: tail!.frame.origin.x, y: tail!.frame.origin.y, width: tailImage.size.width, height: tailImage.size.height)
        
        // Set anchor points and offsets.
        
        //        backgroundColor = UIColor.greenColor()
        if isAnglefish {
            head!.layer.anchorPoint = CGPoint(x: 1.1, y: 0.5)
            head!.center.x += head!.frame.width / 2 + 7
            
            tail!.layer.anchorPoint = CGPoint(x: 0.09, y: 0.5)
            tail!.center.y += 1.5
            tail!.center.x += tail!.frame.width / 4 + tail!.frame.width
        } else {
            head!.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
            head!.center.x += head!.frame.width / 2
            tail!.layer.anchorPoint = CGPoint(x: 0.05, y: 0.5)
            tail!.center.x += tail!.frame.width
        }
        
        self.addSubview(tail!)
        self.addSubview(head!)
        
            
        self.layer.transform = CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 0)
        startSwimming()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSwimming() {
        let degreesVariance:CGFloat = 8
        let radiansToRotate = degreesVariance * CGFloat(M_PI) / 180
        
        let zRotationFrom = CATransform3DMakeRotation(radiansToRotate, 0, 0, 1.0)
        let zRotationTo = CATransform3DMakeRotation(-radiansToRotate, 0, 0, 1.0)
        
        let tailAnimation = CABasicAnimation(keyPath: "transform")
        tailAnimation.fromValue = NSValue( CATransform3D:zRotationFrom )
        tailAnimation.toValue = NSValue( CATransform3D:zRotationTo )
        tailAnimation.duration = 1.0
        tailAnimation.autoreverses = true
        tailAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        tailAnimation.repeatCount = .infinity
        
        tail!.layer.addAnimation(tailAnimation, forKey: "transform")
        
        
        let headDegreesVariance:CGFloat = 1.5
        let headRadiansToRotate = headDegreesVariance * CGFloat(M_PI) / 180
        
        let headZRotationFrom = CATransform3DMakeRotation(-headRadiansToRotate, 0, 0, 1.0)
        let headZRotationTo = CATransform3DMakeRotation(headRadiansToRotate, 0, 0, 1.0)
        
        let headAnimation = CABasicAnimation(keyPath: "transform")
        headAnimation.fromValue = NSValue( CATransform3D:headZRotationFrom )
        headAnimation.toValue = NSValue( CATransform3D:headZRotationTo )
        headAnimation.duration = 1.0
        headAnimation.autoreverses = true
        headAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        headAnimation.repeatCount = .infinity
        
        head!.layer.addAnimation(headAnimation, forKey: "transform")
    }
    
    func toggleLight() {
        if (head!.image == headImage) {
            head!.image = headImageNight
            tail!.image = tailImageNight
        } else {
            head!.image = headImage
            tail!.image = tailImage
        }
    }
    func lightOn() {
        head!.image = headImage
        tail!.image = tailImage
    }
    func lightOff() {
        head!.image = headImageNight
        tail!.image = tailImageNight
    }
    
    func applyHue(source: UIImage, color: Double) -> UIImage {
        let context = CIContext(options: nil)
        // Create an image to filter
        let inputImage = CIImage(image: source)
        // Create a random color to pass to a filter
        //        let color = [kCIInputAngleKey: color]
        // Apply a filter to the image
        let filteredImage = inputImage!.imageByApplyingFilter("CIHueAdjust", withInputParameters: [kCIInputAngleKey: color])
        // Render the filtered image
        let renderedImage = context.createCGImage(filteredImage, fromRect: filteredImage.extent)
        // Return a UIImage
        return UIImage(CGImage: renderedImage)
    }
    
}




//
//  Fish.swift
//  CIS55Lab3_MatthewTso
//
//  Created by Matthew Tso on 5/18/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

//import UIKit
//
//class Fish: UIImageView {// NSObject {
//    var imageLeft: UIImage?
//    var imageRight: UIImage?
//    var darkImageLeft: UIImage?
//    var darkImageRight: UIImage?
//    
//    var inFront = false
//    var facingLeft = true
//    
//    init(imageLeft: UIImage, inFront: Bool, facingLeft: Bool) {
//        super.init(image: imageLeft)
//        
//        self.imageLeft = imageLeft
//        self.inFront = inFront
//        self.facingLeft = facingLeft
//        
//        self.imageRight = UIImage(CGImage: imageLeft.CGImage!, scale: imageLeft.scale, orientation: .UpMirrored)

//        self.darkImageLeft = colorizeImage(imageLeft, withColor: UIColor.grayColor())
//        self.darkImageRight = colorizeImage(self.imageRight!, withColor: UIColor.blackColor())
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

//    func colorizeImage(image: UIImage, withColor color: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
//        let context: CGContextRef = UIGraphicsGetCurrentContext()!
//        var area: CGRect = CGRectMake(0, 0, image.size.width, image.size.height)
//        CGContextScaleCTM(context, 1, -1)
//        CGContextTranslateCTM(context, 0, -area.size.height)
//        CGContextSaveGState(context)
//        CGContextClipToMask(context, area, image.CGImage)
//        color.set()
//        CGContextFillRect(context, area)
////        CGContextSetAlpha(context, 0.5)
//        CGContextRestoreGState(context)
//        CGContextSetBlendMode(context, .Multiply)
////        CGContextSetBlendMode(context, kCGBlendModeMultiply)
//        CGContextDrawImage(context, area, image.CGImage)
//        var colorizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return colorizedImage
//    }
//}
