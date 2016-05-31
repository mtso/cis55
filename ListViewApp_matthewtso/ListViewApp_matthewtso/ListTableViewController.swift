//
//  ListTableViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let cellIdentifier = "ListCell"
    var entries = [
        ChocolateEntry(name: "Raaka Coconut Milk", imageName: "raaka_coconut", taste: "coconut", origin: "Madagascar"),
        ChocolateEntry(name: "Amano Chuao", imageName: "amano_chuao", taste: "—", origin: "—"),
        ChocolateEntry(name: "Amadei Toscano", imageName: "amedei_toscano_nut_brown_gianduja", taste: "nutty", origin: "Tuscany"),
        ChocolateEntry(name: "Chocolate Bonnat", imageName: "chocolate_bonnat", taste: "citrus", origin: "Venezuela"),
        ChocolateEntry(name: "Dick Taylor", imageName: "dicktaylor", taste: "fleur de sel, sea salt", origin: "—"),
        ChocolateEntry(name: "Duffy's", imageName: "duffys_ecuador", taste: "—", origin: "Ecuador"),
        ChocolateEntry(name: "La Dalia", imageName: "friis_holm_la_dalia", taste: "—", origin: "Blend"),
        ChocolateEntry(name: "Nicaliso", imageName: "friis_holm_nicaliso", taste: "—", origin: "Blend"),
        ChocolateEntry(name: "Hershey's", imageName: "hersheys", taste: "—", origin: "—"),
        ChocolateEntry(name: "Marou", imageName: "marou", taste: "—", origin: "—"),
        ChocolateEntry(name: "Mme KIKI & Satomi Kanai", imageName: "mme_kiki_japan", taste: "—", origin: "—"),
        ChocolateEntry(name: "Raaka Sea Salt", imageName: "raaka_sea_salt", taste: "sea salt", origin: "Dominican Republic & Bolivia"),
        ChocolateEntry(name: "Porcelana", imageName: "rogue_porcelana", taste: "—", origin: "—"),
        ChocolateEntry(name: "Tranquilidad", imageName: "rogue_tranquilidad", taste: "—", origin: "—"),
        ChocolateEntry(name: "Soma Allepo Pepper", imageName: "soma_salt_pepper", taste: "salt and pepper", origin: "Peru"),
        ChocolateEntry(name: "La Masica", imageName: "la_masica", taste: "citrus", origin: "Honduras"),
        ChocolateEntry(name: "Mast Mint Chocolate", imageName: "mast_mint_chocolate", taste: "mint", origin: "Peru"),
        ChocolateEntry(name: "Mast Milk Chocolate", imageName: "mast_milk_chocolate", taste: "buttermilk", origin: "Madagascar"),
        ChocolateEntry(name: "Soma Dancing in your Head", imageName: "soma_dancing_chocolate", taste: "smoked wood", origin: "Ghana, Ecuador, Peru"),
        ChocolateEntry(name: "Soma Dark Chocolate", imageName: "soma_dark_chocolate", taste: "toasted corn nuts", origin: "—")
    ]
    var searchController : UISearchController!
    var searchResults = [ChocolateEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Search results updating
    
    func filterContentForSearchText(searchText: String) {
        searchResults = entries.filter({ (entry: ChocolateEntry) -> Bool in
            let nameMatch = entry.name.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            return nameMatch != nil
        })
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContentForSearchText(searchText)
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return searchController.active ? searchResults.count : entries.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListTableViewCell

        // Configure the cell...
        let entry = searchController.active ? searchResults[indexPath.row] : entries[indexPath.row]
        
        cell.cellTitle.text = entry.name
        cell.cellImage.image = UIImage(named: entry.imageName)
        
        cell.cellImage.layer.cornerRadius = 6 //cell.cellImage.frame.size.height * 0.5
        cell.cellImage.clipsToBounds = true
        
        let selectedColorView = UIView()
        selectedColorView.backgroundColor = UIColor(red: 0.92, green:0.87, blue:0.78, alpha:0.3)
        cell.selectedBackgroundView = selectedColorView

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return searchController.active ? false : true
    }


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            entries.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view            
        }    
    }
    

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

    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let detailViewController = segue.destinationViewController as! DetailTableViewController
                
                detailViewController.chocolateEntry = searchController.active ? searchResults[indexPath.row] : entries[indexPath.row]
            }
        }
        else if segue.identifier == "AddNewItem" {
            let addViewController = segue.destinationViewController as! AddItemViewController
            
            addViewController.newChocolateEntry = addData
        }
    }
    
    func addData(newItem: ChocolateEntry) {
        entries.append(newItem)
    }

}
