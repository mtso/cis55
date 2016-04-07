//
//  ViewController.swift
//  HelloWorld
//
//  Created by Matthew Tso on 4/4/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var labelText: UILabel!
    @IBOutlet var btnLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func helloWorldClick(sender: AnyObject) {
        let clickAlert = UIAlertController(title: "Matthew's Hello World", message: "Hello World app works with the Alert Controller.", preferredStyle: UIAlertControllerStyle.Alert)
        clickAlert.addAction(UIAlertAction(title: "Great!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(clickAlert, animated: true, completion: nil)
        
        labelText.text = "Button Clicked!"
        
        btnLabel.setTitle("Button Clicked!", forState: UIControlState.Normal)
    }

}

