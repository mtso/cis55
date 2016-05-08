//
//  ListTableViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    let cellIdentifier = "ListCell"
    var entries = [
        ChocolateEntry(name: "La Masica", imageName: "la_masica", taste: "citrus", origin: "Honduras"),
        ChocolateEntry(name: "Mast Mint Chocolate", imageName: "mast_mint_chocolate", taste: "mint", origin: "Peru"),
        ChocolateEntry(name: "Mast Milk Chocolate", imageName: "mast_milk_chocolate", taste: "buttermilk", origin: "Madagascar"),
        ChocolateEntry(name: "Soma Dancing in your Head", imageName: "soma_dancing_chocolate", taste: "smoked wood", origin: "Ghana, Ecuador, Peru"),
        ChocolateEntry(name: "Soma Dancing in your Head - testing the limits of the text label in this table cell", imageName: "soma_dark_chocolate", taste: "smoked wood", origin: "Ghana, Ecuador, Peru")
    ]

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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            let detailViewController = segue.destinationViewController as! DetailTableViewController
            let indexPath = tableView.indexPathForSelectedRow
            
            detailViewController.chocolateEntry = entries[indexPath!.row]
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListTableViewCell

        // Configure the cell...
        cell.cellTitle.text = entries[indexPath.row].name
        cell.cellImage.image = UIImage(named: entries[indexPath.row].imageName)
        cell.cellImage.layer.cornerRadius = 6 //cell.cellImage.frame.size.height * 0.5
        cell.cellImage.clipsToBounds = true
        
        let selectedColorView = UIView()
        selectedColorView.backgroundColor = UIColor(red: 0.92, green:0.87, blue:0.78, alpha:0.3)
        
        cell.selectedBackgroundView = selectedColorView

                
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
