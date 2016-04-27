//
//  ModalViewController.swift
//  MultipleViewTest
//
//  Created by Matthew Tso on 4/22/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    @IBAction func hideButtonClick(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)

    }
}
