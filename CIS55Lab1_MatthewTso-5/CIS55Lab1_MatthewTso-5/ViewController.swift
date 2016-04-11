//
//  ViewController.swift
//  CIS55Lab1_MatthewTso-5
//
//  Created by Matthew Tso on 4/10/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var field: UITextField!
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClick(sender: AnyObject) {
        // Copy string from UITextField to UILabel.
        label.text = field.text
        
        // Save original Y position of label frame.
        let originalY = label.frame.origin.y
        
        // Set UILabel opacity to 0 to get ready for animation.
        label.layer.opacity = 0.0
        
        // Animate appearance of UILabel.
        UIView.animateWithDuration(0.5, animations: {
            self.label.frame.origin.y -= 50.0
            self.label.layer.opacity = 1.0
        })
        
        // Return UILabel frame value to original.
        label.frame.origin.y = originalY
    }
    
}

