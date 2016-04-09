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
        
        // Attach delegate to UITextView
        messageText.delegate = self
        
        // Start app with the action button disabled
        disableButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func retweetAction(sender: AnyObject) {
        retweet()
    }
    
    func disableButton() {
        retweetButton.backgroundColor = UIColor.lightGrayColor()
        retweetButton.enabled = false
    }
    
    // Retweet action moves string from UITextView to UILabel
    func retweet() {
        labelText.text = messageText.text
        messageText.text = ""
        UIView.transitionWithView(labelText, duration: 0.1, options: [.TransitionFlipFromBottom], animations: nil, completion: nil)
        
        // Reset retweet button.
        retweetButton.setTitle("Retweet After Me   140", forState: .Normal)
        disableButton()
    }
    
    /// UITextView Delegate Methods
    func textViewDidBeginEditing(textView: UITextView) {
        placeholder.hidden = true
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText newText: String) -> Bool {
        // Return Key calls retweet action.
        if (newText == "\n") {
            retweet()
            return false
        }
        // Force maximum 140 characters in UITextView
        let currentCharacterCount = textView.text?.characters.count ?? 0
        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + newText.characters.count - range.length
        if (newLength > 140) {
            // Flash UIButton red to warn user that character limit has been reached.
            UIView.animateWithDuration(0.1, animations: {() -> Void in self.retweetButton.layer.backgroundColor = UIColor.redColor().CGColor}, completion: { _ in })
            UIView.animateWithDuration(0.1, animations: {() -> Void in self.retweetButton.layer.backgroundColor = UIColor(red:0.10, green:0.92, blue:0.62, alpha:1.0).CGColor}, completion: { _ in })
        }
        return newLength <= 140
    }
    func textViewDidChange(textView: UITextView) {
        if (messageText.text?.characters.count > 0) {
            retweetButton.backgroundColor = UIColor(red:0.10, green:0.92, blue:0.62, alpha:1.0)
            retweetButton.enabled = true
        } else {
            disableButton()
        }
        let charactersLeft = 140 - (messageText.text?.characters.count)!
        retweetButton.setTitle("Retweet After Me   " + String(charactersLeft), forState: .Normal)
    }
    func textViewDidEndEditing(textView: UITextView) {
        if (messageText.text.characters.count == 0) {
            placeholder.hidden = false
        }
    }
    
}