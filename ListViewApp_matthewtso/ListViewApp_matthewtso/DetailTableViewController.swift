//
//  DetailTableViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {

    var chocolateEntry: ChocolateEntry?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = chocolateEntry!.name

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        if (indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailImageCell", forIndexPath: indexPath) as! DetailImageTableViewCell
            
            if let image = UIImage(named: chocolateEntry!.imageName) {
                cell.detailImage.image = image
            } else  {
                cell.detailImage.image = UIImage(named: "chocolate_placeholder")
            }

            return cell
        }
        else if (indexPath.row == 1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailTableViewCell
            
            cell.detailTitleLabel.text = "Taste"
            cell.detailDataLabel.text = chocolateEntry?.taste
            return cell
        }
        else if (indexPath.row == 2)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailTableViewCell
            
            cell.detailTitleLabel.text = "Origin"
            cell.detailDataLabel.text = chocolateEntry?.origin
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell", forIndexPath: indexPath) as! DetailTableViewCell
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 400
        } else {
            return 80
        }
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
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