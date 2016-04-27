//
//  ViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/20/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    @IBOutlet var infoToolbar: UIToolbar!
    @IBOutlet var displayTable: UITableView!
    
    // Create a custom transition instance for the session.
    let transition = SlideAnimatedTransitioning()
    var form : FormViewController?
    
    // Initialize bools that are changed to false on the initial setup of the views.
    var appInitialize = true
    var newToolbar = true
    
    // Set up the data variables.
    var startingPay : Double = 0.00
    var numberOfDays : Int = 0
    var dataArray : [PayDataModel] = []
    
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
    
    func generateDataArray() {
        // Clear the array of data.
        dataArray.removeAll()
        
        // Enter first day into data array based on the starting pay.
        dataArray.append(PayDataModel(day: 1, pay: startingPay, total: startingPay))
        
        for index in 2...numberOfDays {
            let today = index
            let indexOfYesterday = today - 2
            let payForToday = dataArray[indexOfYesterday].pay * 2
            let totalPay = dataArray[indexOfYesterday].total + payForToday
            
            dataArray.append(PayDataModel(day: today, pay: payForToday, total: totalPay))
        }
        
        // Update the table view and scroll to the top.
        displayTable.reloadData()
        displayTable.setContentOffset(CGPointZero, animated:true)
        
        // Update the toolbar.
        setupToolbar()
    }
    
}

