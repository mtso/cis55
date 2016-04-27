//
//  ViewController.swift
//  MultipleViewTest
//
//  Created by Matthew Tso on 4/21/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transition = WipeAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showButtonClick(sender: AnyObject) {
        let modal = storyboard!.instantiateViewControllerWithIdentifier("ModalViewController") as! ModalViewController
                
        modal.transitioningDelegate = self
        presentViewController(modal, animated: true, completion: nil)
    }

}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
}

