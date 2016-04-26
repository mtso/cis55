//
//  ViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/20/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    let transition = SlideAnimatedTransitioning()
    var form : FormViewController?

    var startingPay : Double = 0.00
    var numberOfDays : Int = 0
    var dataArray : [PayDataModel] = []
    
    @IBOutlet var infoToolbar: UIToolbar!
    @IBOutlet var displayTable: UITableView!
    
    var appInitialize = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupToolbar()

        // Set the view controller as the delegate and data source for the table view.
        displayTable.delegate = self
        displayTable.dataSource = self
        displayTable.tableFooterView = UIView(frame: CGRectZero) // Hide extra separators.

        // Initialize the Form View Controller from the storyboard and attach the transitioning delegate.
        form = storyboard!.instantiateViewControllerWithIdentifier("FormViewController") as? FormViewController
        form!.transitioningDelegate = self
    }
    override func viewDidAppear(animated: Bool) {
        // Present the Form View the first time the app loads (when there is no input).
        if appInitialize{
            presentViewController(form!, animated: true, completion: nil)
            appInitialize = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func editButtonClick(sender: AnyObject) {
        // Presents the Form View when the Edit button in the toolbar is clicked.
        presentViewController(form!, animated: true, completion: nil)
    }

}

