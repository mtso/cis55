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
    
    override func prefersStatusBarHidden() -> Bool {
        // The form view is kind of a modal, so hide the status bar in this view.
        return true
    }
    
    override func viewDidLoad() {
        // Set the view controller as the delegate of the text fields.
        startingPayField.delegate = self
        numberOfDaysField.delegate = self
        
        // Get the keyboard frame change notification.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if appInitialize {
            // Start the app with the starting pay field selected.
            startingPayField.becomeFirstResponder()
            
            // Hide the cancel button because there is no initial value for the starting pay.
            cancelButton.hidden = true
            
            // Set bool to false for the next time the view appears.
            appInitialize = false
        } else {
            // Unhide the cancel button.
            cancelButton.hidden = false
            
            // Apply a currency number format to the starting pay number.
            let currencyFormatter = NSNumberFormatter()
            currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
            
            let formattedStartingPay = currencyFormatter.stringFromNumber(startingPay!)
            
            // Set the text fields to hold data from the previous calculation.
            startingPayField.text = formattedStartingPay
            numberOfDaysField.text = String(numberOfDays!)
        }
    }

    @IBAction func calculateButtonClick(sender: AnyObject) {
        // Make sure the textfields contain values when the calculate button is clicked, 
        // or else shake the text fields that need input.
        if startingPayField.text == "" && numberOfDaysField.text == "" {
            shakeTextField(startingPayField)
            shakeTextField(numberOfDaysField)
        } else if startingPayField.text == "" {
            shakeTextField(startingPayField)
        } else if numberOfDaysField.text == "" {
            shakeTextField(numberOfDaysField)
        } else {
            // There are values in both textfields, so take the number values from each.
            // Drop the currency symbol from the string.
            var startingPayNumber = String(startingPayField.text!.characters.dropFirst())
            // Take out the commas.
            startingPayNumber = startingPayNumber.stringByReplacingOccurrencesOfString(",", withString: "")
            
            // Set the startingPay value to the double cast from the edited string.
            startingPay = Double(startingPayNumber)
            
            // Set the numberOfDays value to the integers cast from the text field (there should be only numbers here).
            numberOfDays = Int(numberOfDaysField.text!)
        
            // Get the presenting view controller to access the properties and functions.
            let displayViewController : DisplayViewController = presentingViewController as! DisplayViewController
            
            // Set the startingPay and numberOfDays properties in the display view controller to the new values.
            displayViewController.startingPay = startingPay!
            displayViewController.numberOfDays = numberOfDays!
            
            // Regenerate the data array with the new values.
            displayViewController.generateDataArray()
            
            // Dismiss the form view and show the display view with the updated information.
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }

    @IBAction func cancelButtonClick(sender: AnyObject) {
        // Cancel button action dismisses the View without changing the startPay or numberOfDays values.
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func keyboardWillChange(notification: NSNotification) {
        // Make sure the calculate button sticks to the top of the keyboard and
        // stays at the bottom of the screen when the keyboard isn't present.
        
        // Get the start and end frame of the keyboard animation in CGRect.
        let keyboardSizeBegin = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardSizeEnd = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // Calculate height change in keyboard position.
        let deltaHeight = keyboardSizeBegin.origin.y - keyboardSizeEnd.origin.y
        
        // Add height change to button constraint so that:
        self.calculateButtonToViewBottom.constant += deltaHeight
    }
    
    func shakeTextField(textField: UITextField) {
        // Create a basic animation of the text field position.
        let animation = CABasicAnimation(keyPath: "position")
        let intensity : CGFloat = 8.0
        animation.duration = 0.08
        animation.repeatCount = 1
        animation.autoreverses = true
        animation.fromValue = NSValue(CGPoint: CGPointMake(textField.center.x - intensity, textField.center.y))
        animation.toValue = NSValue(CGPoint: CGPointMake(textField.center.x + intensity, textField.center.y))
        
        // Add the animation to the correct text field's layer.
        textField.layer.addAnimation(animation, forKey: "position")
    }
}
