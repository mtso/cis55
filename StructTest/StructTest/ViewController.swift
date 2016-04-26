//
//  ViewController.swift
//  StructTest
//
//  Created by Matthew Tso on 4/22/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var startingPayField: UITextField!
    @IBOutlet var payTable: UITableView!
    var payDataArray : [PayData] = []
    
    let numberOfDays = 30 // set Maximum to 999 days (so disallow more than 4 digits)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        startingPayField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func calculateButtonClick(sender: AnyObject) {
        payDataArray.removeAll()
        
        let startPay = Double(startingPayField.text!)!
        
        payDataArray.append(PayData(day: 1, pay: startPay, total: startPay))
        
        for index in 2...numberOfDays {
            let today = index
            
            let indexOfYesterday = today - 2
            let payForDay = payDataArray[indexOfYesterday].pay * 2
            let totalPay = payDataArray[indexOfYesterday].total + payForDay
            
            payDataArray.append(PayData(day: today, pay: payForDay, total: totalPay))
            
        }
        payTable.reloadData()
        
        startingPayField.resignFirstResponder()
        
    }
    
}

