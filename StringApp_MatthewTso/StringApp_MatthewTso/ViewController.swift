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
    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func convertButtonClick(sender: AnyObject) {
        let inputText = inputTextField.text
        
        let charactersInInput = inputText!.characters.count
        
        let uppercaseSet = NSCharacterSet.uppercaseLetterCharacterSet()
        let lowercaseSet = NSCharacterSet.lowercaseLetterCharacterSet()
        let numeralSet = NSCharacterSet.decimalDigitCharacterSet()
        let nonAlphanumericSet = NSMutableCharacterSet.invert(NSMutableCharacterSet.alphanumericCharacterSet())
        
//        let uppercaseRange = inputText?.rangeOfCharacterFromSet(uppercaseSet)
        
        var numberOfUppercase = 0
        
        var characters = [String]()
        
        for character in inputText!.characters {
            characters.append(String(character))
        }
        
        for character in characters {
            let range = character.rangeOfCharacterFromSet(uppercaseSet)

            if let test = range {
                print(test)
                numberOfUppercase++
            } else {
                print("not")
            }
        }
        
        
        
        infoLabel.text = String(charactersInInput) + " Characters, " + String(numberOfUppercase) + " Uppercase letters."
    }

}

