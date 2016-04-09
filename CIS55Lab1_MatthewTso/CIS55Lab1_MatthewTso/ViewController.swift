//
//  ViewController.swift
//  CIS55Lab1_MatthewTso
//
//  Created by Matthew Tso on 4/6/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var labelText: UILabel!
    @IBOutlet var btnText: UIButton!
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtField.delegate = self
        btnText.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(sender: AnyObject) {
//        let enteredText = txtField.text
//        labelText.text = enteredText
        
//        labelText.text = txtField.text
//        
//        UIView.transitionWithView(labelText, duration: 0.7, options: [.TransitionFlipFromBottom], animations: nil, completion: nil)
        
        tweetText()
        
    }
    
    func tweetText() {
        labelText.text = txtField.text
        
        UIView.transitionWithView(labelText, duration: 0.7, options: [.TransitionFlipFromBottom], animations: nil, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == txtField {
            //textField.resignFirstResponder()
            //labelText.text = txtField.text
            tweetText()
            return false
        }
        return true
    }
    
    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.characters.count ?? 0
        let charactersLeft = 140 - currentCharacterCount
        
        if (textField.text?.characters.count >= 0){
            btnText.enabled = true
            //        let btnMsg:String = "Retweet After Me \(charactersLeft)" +
        } else if (textField.text?.characters.count = -1) {
            btnText.enabled = false
        }
        
        btnText.setTitle("Retweet After Me \(charactersLeft)", forState: UIControlState.Normal)
        

        

        if (range.length + range.location > currentCharacterCount){
            return false
        }
        let newLength = currentCharacterCount + string.characters.count - range.length
        
        return newLength <= 140
    }

}

