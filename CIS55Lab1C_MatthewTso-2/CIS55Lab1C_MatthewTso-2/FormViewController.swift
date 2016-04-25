//
//  FormViewController.swift
//  CIS55Lab1C_MatthewTso-2
//
//  Created by Matthew Tso on 4/24/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateButtonClick(sender: AnyObject) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if (segue.identifier == "ShowTable") {
//            
//        }
        let destVC = segue.destinationViewController as! ViewController
        
        destVC.startNumber = Int(textField.text!)
        
        destVC.generateTable()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
