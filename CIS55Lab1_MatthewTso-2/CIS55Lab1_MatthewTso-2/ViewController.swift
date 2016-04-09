//
//  ViewController.swift
//  CIS55Lab1_MatthewTso-2
//
//  Created by Matthew Tso on 4/7/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    
    // Placeholder UILabel because UITextView does not have placeholder text attribute.
    @IBOutlet var placeholder: UILabel!
    @IBOutlet var labelText: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet weak var messageText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Attach delegate to UITextView.
        messageText.delegate = self
        
        // Start app with the action button disabled.
        disableButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func retweetAction(sender: AnyObject) {
        retweet()
    }
    
    // Retweet action moves string from UITextView to UILabel.
    func retweet() {
        labelText.text = messageText.text
        messageText.text = ""
        UIView.transitionWithView(labelText, duration: 0.1, options: [.TransitionFlipFromBottom], animations: nil, completion: nil)
        
        // Reset retweet button.
        retweetButton.setTitle("Retweet After Me   140", forState: .Normal)
        disableButton()
    }
    
    // Set the background color of the disabled button to light gray.
    func disableButton() {
        retweetButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0)
        retweetButton.enabled = false
    }
    
    // Flash background color of UITextView red. Called when an invalid text manipulation is attempted.
    func flashRed() {
        UITextView.animateWithDuration(0.1, animations: {() -> Void in self.messageText.layer.backgroundColor = UIColor.redColor().CGColor}, completion: { _ in })
        UITextView.animateWithDuration(0.1, animations: {() -> Void in self.messageText.layer.backgroundColor = UIColor.whiteColor().CGColor}, completion: { _ in })
    }
    
    // UITextView Delegate Methods.
    func textViewDidBeginEditing(textView: UITextView) {
        // Hide the placeholder label when the UITextView becomes the first responder.
        placeholder.hidden = true
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText newText: String) -> Bool {
        // Return Key calls retweet action.
        if (newText == "\n") {
            retweet()
            return false
        }
        // Force maximum 140 characters in UITextView.
        let currentCharacterCount = textView.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            flashRed()
            return false
        }
        let newLength = currentCharacterCount + newText.characters.count - range.length
        if (newLength > 140) {
            flashRed()
            return false
        } else {
            return true
        }
    }
    func textViewDidChange(textView: UITextView) {
        // Enable the retweet button when text is added into the UITextView.
        // Disable the retweet button if there is no text after the text manipulation.
        if (messageText.text?.characters.count > 0) {
            retweetButton.backgroundColor = UIColor(red:0.00, green:0.90, blue:0.65, alpha:1.0)
            retweetButton.enabled = true
        } else {
            disableButton()
        }
        // Show user the remaining characters available in the tweet.
        let charactersLeft = 140 - (messageText.text?.characters.count)!
        retweetButton.setTitle("Retweet After Me   " + String(charactersLeft), forState: .Normal)
    }
    func textViewDidEndEditing(textView: UITextView) {
        // Display placeholder label if the UITextView is empty upon resigning as first responder.
        if (messageText.text.characters.count == 0) {
            placeholder.hidden = false
        }
    }
    
}