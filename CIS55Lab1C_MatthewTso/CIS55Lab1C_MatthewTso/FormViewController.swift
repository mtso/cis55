//
//  FormViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/23/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var startingPayLabel: UILabel!
    @IBOutlet var numberOfDaysLabel: UILabel!
    @IBOutlet var startingPayField: UITextField!
    @IBOutlet var numberOfDaysField: UITextField!
    
    var appInitialize = true
    
    override func viewDidAppear(animated: Bool) {
        if appInitialize {
            startingPayField.becomeFirstResponder()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Force UITextField to be Thin weight
        let bigThinFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        startingPayField.font = bigThinFont
        numberOfDaysField.font = bigThinFont
        
        startingPayField.adjustsFontSizeToFitWidth = true
        startingPayField.minimumFontSize = 0.5
        
        let payPlaceholder = NSMutableAttributedString(string: "$0.00", attributes: [
            NSFontAttributeName: UIFont.systemFontOfSize(80.0, weight: UIFontWeightThin)])
        
        payPlaceholder.setAttributes([
            NSFontAttributeName: UIFont.systemFontOfSize(30.0, weight: UIFontWeightRegular),
            NSBaselineOffsetAttributeName: 36.0
            ], range: NSRange(location: 0, length: 1))
        
        
        startingPayField.attributedPlaceholder = payPlaceholder
    }

    @IBAction func calculateButtonClick(sender: AnyObject) {
        let displayViewController : DisplayViewController = presentingViewController as! DisplayViewController
        displayViewController.startingPay = Double(startingPayField.text!)!
        displayViewController.generateDataArray()
        
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
