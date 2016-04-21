//
//  ViewController.swift
//  CISLab1C_MatthewTso_sketch
//
//  Created by Matthew Tso on 4/20/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var startingPay: UITextField!
    @IBOutlet var numberOfDays: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        startingPay.tintColor = UIColor(red: 20.0, green: 200.0, blue: 135.0, alpha: 1.0)
        
//        startingPay.adjustsFontSizeToFitWidth = false
//        numberOfDays.adjustsFontSizeToFitWidth = false
//        
//        startingPay.font = UIFont(name: "Avenir", size: 60.0)
//        numberOfDays.font = UIFont(name: "Avenir", size: 60.0)
//        
//        startingPay.becomeFirstResponder()
        
        
        
//        let formStoryboard = UIStoryboard(name: "Form", bundle: nil)
//        let formViewController : AnyObject! = formStoryboard.instantiateViewControllerWithIdentifier("FormViewController")
        
        let controller = storyboard?.instantiateViewControllerWithIdentifier("FormViewController")
        
//        showViewController(FormViewController as UIViewController, sender: formViewController)
        presentViewController(controller!, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

