//
//  FormViewControllerExtensions.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/24/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

extension FormViewController: UITextFieldDelegate {
    func keyboardWillChange(notification: NSNotification) {
        // Get the start and end frame of the keyboard animation in CGRect.
        let keyboardSizeBegin = (notification.userInfo![UIKeyboardFrameBeginUserInfoKey] as! NSValue).CGRectValue()
        let keyboardSizeEnd = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        // Calculate height change in keyboard position.
        let deltaHeight = keyboardSizeBegin.origin.y - keyboardSizeEnd.origin.y
        
        // Add height change to panel constraint.
        self.calculateButtonToViewBottom.constant += deltaHeight
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField == startingPayField {
            
            let currentCharacterCount = textField.text?.characters.count ?? 0
            
            // Check if the range to replace is in the current string to protect against the system attempting to undo a previously invalidated paste operation.
            if (range.length + range.location > currentCharacterCount){
                shakeTextField(startingPayField)
                return false
            }
            
            // Prevent the text change if the new string exceeds 140 characters.
            let newLength = currentCharacterCount + string.characters.count - range.length
            if (newLength > 6) {
                //                textViewWarning()
                shakeTextField(startingPayField)
                return false
            }

            let decimal = NSCharacterSet(charactersInString: ".")
            if textField.text?.rangeOfCharacterFromSet(decimal) != nil {
                print(string.rangeOfCharacterFromSet(decimal))
                if string == "." || string.rangeOfCharacterFromSet(decimal) != nil {
                    shakeTextField(startingPayField)
                    return false
                }
                
                let integerAndFraction: [String] = textField.text!.componentsSeparatedByCharactersInSet(decimal)
                
                if range.location >= textField.text!.characters.count - integerAndFraction[1].characters.count {
                    
                    // Force maximum 3 numbers in UITextView.
                    let currentDigitsAfterDecimal = integerAndFraction[1].characters.count ?? 0
                    
                    // Check if the range to replace is in the current string to protect against the system attempting to undo a previously invalidated paste operation.
                    //                if (range.length + range.location - integerAndFraction[0].characters.count > currentDigitsAfterDecimal){
                    //                    return false
                    //                }
                    
                    // Prevent the text change if the new string exceeds 140 characters.
                    let newDigits = currentDigitsAfterDecimal + string.characters.count - range.length
                    if (newDigits > 2) {
                        shakeTextField(startingPayField)
                        return false
                    } else {
                        return true
                    }
                }
                
            }
            
            if textField.text == "" {
                textField.text = "$"
                if string == "." {
                    textField.text = "$0"
                }
            } else if range.location == 0 && string == "" {
                return false
            } else if textField.text?.characters.count == 2 && string == "" && range.location == 1 {
                textField.text = ""
                return false
            } else if textField.text == "$0." && string == "" {
                textField.text = ""
                return false
            }
            
            
            
        }
        
        
        
        if textField == numberOfDaysField {
            // Force maximum 3 numbers in UITextView.
            let currentCharacterCount = textField.text?.characters.count ?? 0
            
            // Check if the range to replace is in the current string to protect against the system attempting to undo a previously invalidated paste operation.
            if (range.length + range.location > currentCharacterCount){
                return false
            }
            
            // Prevent the text change if the new string exceeds 140 characters.
            let newLength = currentCharacterCount + string.characters.count - range.length
            if (newLength > 3) {
                shakeTextField(numberOfDaysField)
                return false
            } else {
                return true
            }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        if textField == startingPayField {
//            
//        }
        return true
    }
    
    func checkCalculateButton() {

    }
}