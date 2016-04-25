//
//  ViewController.swift
//  CIS55Lab1C_MatthewTso-2
//
//  Created by Matthew Tso on 4/23/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var dataTable: UITableView!
    let rows = 10
    
    var data = [1, 2, 3]
    var startNumber : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dataTable.delegate = self
        dataTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "data " + String(data[indexPath.row])
        
        return cell
    }
    
    func generateTable() {
        let startValue: Int = startNumber!
        
        data.removeAll()
        
        for index in 0..<rows {
            data.append(startValue * 2)
        }
        
    }
}

