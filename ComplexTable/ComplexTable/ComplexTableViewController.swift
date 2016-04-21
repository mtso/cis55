//
//  ComplexTableViewController.swift
//  ComplexTable
//
//  Created by Matthew Tso on 4/18/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ComplexTableViewController: UITableViewController {
    
    @IBOutlet var cellImage: UIImageView!
    @IBOutlet var itemName: UILabel!
    @IBOutlet var itemType: UILabel!
    
    var ToDoItems = ["Buy Groceries", "Pickup Laundry", "Wash Car", "Return Library Books", "Finish Assignment"]
    var ToDoTimes = ["10:00AM", "11:00AM", "12:00AM", "1:00AM", "2:00AM"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ToDoItems.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let ToDoCellID = "ToDoCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(ToDoCellID, forIndexPath: indexPath) as! ToDoTableViewCell

         // Configure the cell...
        
//        cell.textLabel!.text = ToDoItems[indexPath.row]
//        cell.imageView?.image = UIImage(named: "placeholder")
        
        cell.cellImage?.image = UIImage(named: "placeholder")
        cell.cellItemName?.text = ToDoItems[indexPath.row]
        cell.cellItemType?.text = ToDoTimes[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
