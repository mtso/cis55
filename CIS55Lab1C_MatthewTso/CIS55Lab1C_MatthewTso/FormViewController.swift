//
//  FormViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/23/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet var startingPayLabel: UILabel!
    @IBOutlet var numberOfDaysLabel: UILabel!
    @IBOutlet var startingPayField: UITextField!
    @IBOutlet var numberOfDaysField: UITextField!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var calculateButton: UIButton!
    
    @IBOutlet var calculateButtonToViewBottom: NSLayoutConstraint!
    
    var startingPay : Double?
    var numberOfDays : Int?
    
    var appInitialize = true
    
    override func viewDidLoad() {

        startingPayField.delegate = self
        numberOfDaysField.delegate = self
        
        
//        startingPayField.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)

//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange:", name:UITextFieldTextDidChangeNotification, object: startingPayField)
        
//        startingPayField.adjustsFontSizeToFitWidth = false
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        startingPayField.delegate = self
//        numberOfDaysField.delegate = self
        
//        calculateButton.enabled = false
        
        let bigThinFont = UIFont.systemFontOfSize(80, weight: UIFontWeightThin)
        
        if appInitialize {
            startingPayField.becomeFirstResponder()
            cancelButton.hidden = true
            
            appInitialize = false
        } else {
            cancelButton.hidden = false
            
            let currencyFormatter = NSNumberFormatter()
            currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            let formattedStartingPay = currencyFormatter.stringFromNumber(startingPay!)
            
            startingPayField.text = formattedStartingPay
            numberOfDaysField.text = String(numberOfDays!)
            
            startingPayField.font = bigThinFont
            
        }
        
        // Force UITextField to be Thin weight
        startingPayField.font = bigThinFont
        numberOfDaysField.font = bigThinFont
        
        startingPayField.adjustsFontSizeToFitWidth = true
        startingPayField.minimumFontSize = 0.5
        
//        let payPlaceholder = NSMutableAttributedString(string: "$0.00", attributes: [
//            NSFontAttributeName: UIFont.systemFontOfSize(80.0, weight: UIFontWeightThin)])
        
//        payPlaceholder.setAttributes([
//            NSFontAttributeName: UIFont.systemFontOfSize(30.0, weight: UIFontWeightRegular),
//            NSBaselineOffsetAttributeName: 36.0
//            ], range: NSRange(location: 0, length: 1))
        
        
//        startingPayField.attributedPlaceholder = payPlaceholder
    }

    @IBAction func calculateButtonClick(sender: AnyObject) {
        if startingPayField.text == "" && numberOfDaysField.text == "" {
            shakeTextField(startingPayField)
            shakeTextField(numberOfDaysField)
        } else if startingPayField.text == "" {
            shakeTextField(startingPayField)
        } else if numberOfDaysField.text == "" {
            shakeTextField(numberOfDaysField)
        } else {
            var startingPayNumber = String(startingPayField.text!.characters.dropFirst())
            
            startingPayNumber = startingPayNumber.stringByReplacingOccurrencesOfString(",", withString: "")
            
            startingPay = Double(startingPayNumber)
            
            numberOfDays = Int(numberOfDaysField.text!)
        
            let displayViewController : DisplayViewController = presentingViewController as! DisplayViewController
            displayViewController.startingPay = startingPay!
            displayViewController.numberOfDays = numberOfDays!
        
            displayViewController.generateDataArray()
        
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func cancelButtonClick(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func shakeTextField(textField: UITextField) {
        let animation = CABasicAnimation(keyPath: "position")
        let intensity : CGFloat = 8
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - intensity, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + intensity, textField.center.y))
        textField.layer.addAnimation(animation, forKey: "position")
    }
}
