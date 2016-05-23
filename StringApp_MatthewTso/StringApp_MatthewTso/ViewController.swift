//
//  ViewController.swift
//  StringApp_MatthewTso
//
//  Created by Matthew Tso on 5/11/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var outputTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        inputTextField.layer.borderWidth = 1
        inputTextField.layer.borderColor = UIColor(red:0.20, green:0.47, blue:0.18, alpha:1.0).CGColor
        inputTextField.tintColor = UIColor(red:0.20, green:0.47, blue:0.18, alpha:1.0)
        
        outputTextView.layer.borderWidth = 1
        outputTextView.layer.borderColor = UIColor(red:0.20, green:0.47, blue:0.18, alpha:1.0).CGColor
        
//        infoLabel.backgroundColor = UIColor(red:0.20, green:0.47, blue:0.18, alpha:1.0)
//        outputTextView.bounds = CGRect(x: outputLabel.frame.origin.x + 10, y: outputLabel.frame.origin.y, width: outputLabel.frame.width, height: outputLabel.frame.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertButtonClick(sender: AnyObject) {
        inputTextField.resignFirstResponder()
        
        let inputText = inputTextField.text
        
        let charactersInInput = inputText!.characters.count
        
        let uppercaseSet = NSCharacterSet.uppercaseLetterCharacterSet()
        let lowercaseSet = NSCharacterSet.lowercaseLetterCharacterSet()
        let numeralSet = NSCharacterSet.decimalDigitCharacterSet()
//        let nonAlphanumericSet = NSMutableCharacterSet.invert(NSMutableCharacterSet.alphanumericCharacterSet())
        let nonAlphanumericSet = NSMutableCharacterSet.alphanumericCharacterSet().invertedSet
        
//        let uppercaseRange = inputText?.rangeOfCharacterFromSet(uppercaseSet)
        
        var numberOfUppercase = 0
        var numberOfLowercase = 0
        var numberOfNumerals = 0
        var numberOfNonAlphanumeric = 0
        
        var outputString = ""
        
        for character in inputText!.characters {
            
            if let _ = String(character).rangeOfCharacterFromSet(uppercaseSet)
            {
                numberOfUppercase++
                outputString += String(character).lowercaseString
            }
            else if let _ = String(character).rangeOfCharacterFromSet(lowercaseSet)
            {
                numberOfLowercase++
                outputString += String(character).uppercaseString
            }
            else if let _ = String(character).rangeOfCharacterFromSet(numeralSet)
            {
                numberOfNumerals++
                outputString += String(character)
            }
            else if let _ = String(character).rangeOfCharacterFromSet(nonAlphanumericSet)
            {
                numberOfNonAlphanumeric++
                outputString += String(character)
            }

        }
        
        
                outputTextView.text = outputString
    }

}

