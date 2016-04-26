//
//  WipeAnimatedTransitioning.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/21/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class SlideAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 0.6
    var presenting = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()!
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        let modalView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)
        
        let translationHeight = -modalView!.frame.height
        let transformation = CGAffineTransformMakeTranslation(0, translationHeight)
        
        if presenting {
            modalView!.transform = transformation
        }
        
        containerView.addSubview(toView!)
        containerView.bringSubviewToFront(modalView!)
        
        UIView.animateWithDuration(duration, delay: 0.0,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: CGFloat(duration * 1.4),
            options: .CurveEaseOut,
            animations: {
                modalView?.transform = self.presenting ? CGAffineTransformIdentity : transformation
            }, completion: {_ in
                transitionContext.completeTransition(true)
        })
        
    }
}
