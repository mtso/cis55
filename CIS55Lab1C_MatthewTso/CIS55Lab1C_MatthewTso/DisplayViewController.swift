//
//  ViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/20/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController {

    let transition = PushAnimatedTransitioning()
    
    var startingPay : Double = 0.00
    var numberOfDays : Int = 0
    
    @IBOutlet var infoToolbar: UIToolbar!
    
    @IBOutlet var displayTable: UITableView!
    
    var form : FormViewController?
    
    var dataArray : [PayDataModel] = []
    
    var appInitialize = true
    
//    var readyToGenerate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupToolbar()

        displayTable.delegate = self
        displayTable.dataSource = self
        
        form = storyboard!.instantiateViewControllerWithIdentifier("FormViewController") as? FormViewController
        form!.transitioningDelegate = self
//        presentViewController(form!, animated: true, completion: nil)
        
        
        let screenSize = UIScreen.mainScreen().bounds.width
        print(screenSize)
//        let screenWidth 
        
    }
    override func viewDidAppear(animated: Bool) {
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
//        form!.transitioningDelegate = self
        presentViewController(form!, animated: true, completion: nil)

    }

}

