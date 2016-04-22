//
//  PopAnimator.swift
//  BeginnerCook
//
//  Created by Matthew Tso on 4/21/16.
//  Copyright © 2016 Underplot ltd. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        let initialFrame = presenting ? originFrame : herbView?.frame
        let finalFrame = presenting ? herbView!.frame : originFrame
        
        let xScaleFactor = presenting ?
            initialFrame!.width / finalFrame.width :
            finalFrame.width / initialFrame!.width
        let yScaleFactor = presenting ?
            initialFrame!.height / finalFrame.height :
            finalFrame.height / initialFrame!.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            herbView!.transform = scaleTransform
            herbView!.center = CGPoint (x: CGRectGetMidX(initialFrame!), y: CGRectGetMidY(initialFrame!))
            herbView?.clipsToBounds = true
        }
        
        containerView.addSubview(toView!)
        containerView.bringSubviewToFront(herbView!)
        
        UIView.animateWithDuration(duration, delay: 0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                herbView?.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView!.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            },
            completion: {_ in transitionContext.completeTransition(true)})
        
    }

}
