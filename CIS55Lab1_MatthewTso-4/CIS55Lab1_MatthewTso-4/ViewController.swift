//
//  ViewController.swift
//  CIS55Lab1_MatthewTso-4
//
//  Created by Matthew Tso on 4/9/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var editPanel: UIView!
    @IBOutlet var placeholder: UILabel!
    @IBOutlet var message: UITextView!
    @IBOutlet var panelBottom: NSLayoutConstraint!
    @IBOutlet var retweetButton: UIButton!
    
    var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Attach delegate to message UITextView.
        message.delegate = self
        
        // Disable retweet button on app start.
        disableButton()
        
        // Listen to keyboard frame change notification.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChange:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // Draw and hide panel shadow
        editPanel.layer.masksToBounds = false
        editPanel.layer.shadowOffset = CGSizeMake(0.0, 0.0)
        editPanel.layer.shadowRadius = 10.0
        editPanel.layer.shadowOpacity = 0.0
        
        // Set up gesture recognizer.
        tap = UITapGestureRecognizer(target: self, action: "dismissEditPanel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func retweetAction(sender: AnyObject) {
        // Call retweet method when the button is pressed.
        retweet()
    }
    
    func retweet() {
        // Check if there is text in the UITextView.
        if (message.text == "") {
            textViewWarning()
        } else {
            // Copy message text to output label.
            outputLabel.text = message.text
            
            // Animate output label flip.
            UIView.transitionWithView(outputLabel, duration: 0.5, options: [.TransitionFlipFromBottom], animations: nil, completion: nil)
            
            // Clear UITextView.
            message.text = ""
            message.resignFirstResponder()
            
            // Reset retweet button.
            UIView.setAnimationsEnabled(false)
            retweetButton.setTitle("Retweet After Me   140", forState: .Normal)
            retweetButton.layoutIfNeeded()
            UIView.setAnimationsEnabled(true)
            disableButton()
            
            // Show placeholder label.
            placeholder.hidden = false
        }
    }
    
    func disableButton() {
        retweetButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        retweetButton.enabled = false
    }
    
    func textViewWarning() {
        // Animate panel border to warn user.
        
        // Increase border width.
        editPanel.layer.borderColor = UIColor.redColor().CGColor
        let borderOn = CABasicAnimation(keyPath: "borderWidth")
        borderOn.fromValue = 0.0
        borderOn.toValue = 4.0
        borderOn.duration = 0.1
        
        // Decrease border width.
        editPanel.layer.addAnimation(borderOn, forKey: "borderWidth")
        let borderOff = CABasicAnimation(keyPath: "borderWidth")
        borderOff.fromValue = 4.0
        borderOff.toValue = 0.0
        borderOff.duration = 0.1
        editPanel.layer.addAnimation(borderOff, forKey: "borderWidth")
    }
    
    func dismissEditPanel() {
        message.resignFirstResponder()
        self.view.removeGestureRecognizer(tap)
    }
    
    /*
     * Method that receives the keyboard frame change notification.
     */
    func keyboardWillChange(notification: NSNotification) {
        // Get the start and end frame of the keyboard animation in CGRect.
        let keyboardSizeBegin = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardSizeEnd = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // Calculate height change in keyboard position.
        let deltaHeight = keyboardSizeBegin.origin.y - keyboardSizeEnd.origin.y
        
        
        // Add height change to panel constraint.
        self.panelBottom.constant += deltaHeight
        self.editPanel.setNeedsUpdateConstraints()
        
        // Get duration of keyboard animation.
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        // Create UIViewAnimationOption from keyboard animation curve
        let curveValue = (notification.userInfo![UIKeyboardAnimationCurveUserInfoKey] as! Int)
        let curveOption = UIViewAnimationOptions(rawValue: UInt(curveValue << 16))
        
        // Animate panel to match keyboard.
        UIView.animateWithDuration(duration, delay: 0.0, options: curveOption, animations: {
            self.editPanel.layoutIfNeeded()
            }, completion: { _ in })
    }
    
    /*
     * UITextViewDelegate Methods
     */
    func textViewDidBeginEditing(textView: UITextView) {
        // Hide the placeholder label when the UITextView becomes the first responder.
        placeholder.hidden = true
        
        // Animate edit panel shadow opacity.
        let shadowAnim = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnim.fromValue = 0.0
        shadowAnim.toValue = 0.4
        shadowAnim.duration = 0.4
        editPanel.layer.addAnimation(shadowAnim, forKey: "shadowOpacity")
        
        // Show edit panel shadow after animation.
        editPanel.layer.shadowOpacity = 0.4
        
        // Add gesture recognizer for tap outside of edit panel.
        self.view.addGestureRecognizer(tap)
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText newText: String) -> Bool {
        // Return Key calls retweet action.
        if (newText == "\n") {
            retweet()
            return false
        }
        
        // Force maximum 140 characters in UITextView.
        let currentCharacterCount = textView.text?.characters.count ?? 0
        
        // Check if the range to replace is in the current string to protect against the system attempting to undo a previously invalidated paste operation.
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        
        // Prevent the text change if the new string exceeds 140 characters.
        let newLength = currentCharacterCount + newText.characters.count - range.length
        if (newLength > 140) {
            textViewWarning()
            return false
        } else {
            return true
        }
    }
    func textViewDidChange(textView: UITextView) {
        // Enable the retweet button when text is added into the UITextView.
        if (message.text?.characters.count > 0) {
            retweetButton.backgroundColor = UIColor(red:0.00, green:0.85, blue:0.55, alpha:1.0)
            retweetButton.enabled = true
        } else {
            // Disable the retweet button if there is no text after the text manipulation.
            disableButton()
        }
        
        // Change button title to show the remaining number of characters available in the tweet.
        UIView.setAnimationsEnabled(false)
        let charactersLeft = 140 - (message.text?.characters.count)!
        retweetButton.setTitle("Retweet After Me   " + String(charactersLeft), forState: .Normal)
        retweetButton.layoutIfNeeded()
        UIView.setAnimationsEnabled(true)

    }
    func textViewDidEndEditing(textView: UITextView) {
        // Animate edit panel shadow opacity.
        let shadowAnim = CABasicAnimation(keyPath: "shadowOpacity")
        shadowAnim.fromValue = 0.4
        shadowAnim.toValue = 0.0
        shadowAnim.duration = 0.4
        editPanel.layer.addAnimation(shadowAnim, forKey: "shadowOpacity")
        
        // Hide edit panel shadow after animation.
        editPanel.layer.shadowOpacity = 0.0
        
        // Display placeholder label if the UITextView is empty upon resigning as first responder.
        if (message.text.characters.count == 0) {
            placeholder.hidden = false
        }
    }
    
    
    
}

