//
//  ListTableViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import CoreData

class ListTableViewController: UITableViewController, UISearchResultsUpdating, NSFetchedResultsControllerDelegate {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultsController: NSFetchedResultsController!

    let cellIdentifier = "ListCell"
    var entries = [ChocolateEntry]()
    var searchController : UISearchController!
    var searchResults = [ChocolateEntry]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let fetchRequest = NSFetchRequest(entityName: "ChocolateEntry")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            entries = fetchedResultsController.fetchedObjects as! [ChocolateEntry]

            if entries.isEmpty {
                initializeData()
            }
        } catch {
            print(error)
        }
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = false
        self.definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.contentOffset = CGPoint(x: 0, y: searchController.searchBar.frame.height)
    }
    
    override func viewDidAppear(animated: Bool) {
        let fetchRequest = NSFetchRequest(entityName: "ChocolateEntry")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
            entries = fetchedResultsController.fetchedObjects as! [ChocolateEntry]
        } catch {
            print(error)
        }
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fetched results controller
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRowsAtIndexPaths([_newIndexPath], withRowAnimation: .Fade)
            }
        case .Delete:
            if let _indexPath = indexPath {
                tableView.deleteRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        case .Update:
            if let _indexPath = indexPath {
                tableView.reloadRowsAtIndexPaths([_indexPath], withRowAnimation: .Fade)
            }
        default:
            tableView.reloadData()
        }
        entries = controller.fetchedObjects as! [ChocolateEntry]
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
    
    // MARK: - Update search results
    
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
        if let cellImage = UIImage(named: entry.imageName) {
            cell.cellImage.image = cellImage // UIImage(named: entry.imageName)
        } else {
            cell.cellImage.image = UIImage(named: "chocolate_placeholder")
        }
        
        cell.cellImage.layer.cornerRadius = 6
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
            let itemToDelete = fetchedResultsController.objectAtIndexPath(indexPath) as! ChocolateEntry
            managedObjectContext.deleteObject(itemToDelete)
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
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
        } else if segue.identifier == "AddNewItem" {
            searchController.active = false
        }
    }
    
    @IBAction func cancel(segue: UIStoryboardSegue) {
    }
    
    @IBAction func save(segue: UIStoryboardSegue) {
    }
    
    // MARK: - Initial app data
    
    func initializeData() {
        let initialData = [
                (name: "Raaka Coconut Milk", imageName: "raaka_coconut", taste: "coconut", origin: "Madagascar"),
                (name: "Amano Chuao", imageName: "amano_chuao", taste: "—", origin: "—"),
                (name: "Amadei Toscano", imageName: "amedei_toscano_nut_brown_gianduja", taste: "nutty", origin: "Tuscany"),
                (name: "Chocolate Bonnat", imageName: "chocolate_bonnat", taste: "citrus", origin: "Venezuela"),
                (name: "Dick Taylor", imageName: "dicktaylor", taste: "fleur de sel, sea salt", origin: "—"),
                (name: "Duffy's", imageName: "duffys_ecuador", taste: "—", origin: "Ecuador"),
                (name: "La Dalia", imageName: "friis_holm_la_dalia", taste: "—", origin: "Blend"),
                (name: "Nicaliso", imageName: "friis_holm_nicaliso", taste: "—", origin: "Blend"),
                (name: "Hershey's", imageName: "hersheys", taste: "—", origin: "—"),
                (name: "Marou", imageName: "marou", taste: "—", origin: "—"),
                (name: "Mme KIKI & Satomi Kanai", imageName: "mme_kiki_japan", taste: "—", origin: "—"),
                (name: "Raaka Sea Salt", imageName: "raaka_sea_salt", taste: "sea salt", origin: "Dominican Republic & Bolivia"),
                (name: "Porcelana", imageName: "rogue_porcelana", taste: "—", origin: "—"),
                (name: "Tranquilidad", imageName: "rogue_tranquilidad", taste: "—", origin: "—"),
                (name: "Soma Allepo Pepper", imageName: "soma_salt_pepper", taste: "salt and pepper", origin: "Peru"),
                (name: "La Masica", imageName: "la_masica", taste: "citrus", origin: "Honduras"),
                (name: "Mast Mint Chocolate", imageName: "mast_mint_chocolate", taste: "mint", origin: "Peru"),
                (name: "Mast Milk Chocolate", imageName: "mast_milk_chocolate", taste: "buttermilk", origin: "Madagascar"),
                (name: "Soma Dancing in your Head", imageName: "soma_dancing_chocolate", taste: "smoked wood", origin: "Ghana, Ecuador, Peru"),
                (name: "Soma Dark Chocolate", imageName: "soma_dark_chocolate", taste: "toasted corn nuts", origin: "—")
        ]
        
        for entry in initialData {
            let initialChocolateEntry = NSEntityDescription.insertNewObjectForEntityForName("ChocolateEntry", inManagedObjectContext: managedObjectContext) as! ChocolateEntry
            
            initialChocolateEntry.name = entry.name
            initialChocolateEntry.imageName = entry.imageName
            initialChocolateEntry.taste = entry.taste
            initialChocolateEntry.origin = entry.origin
            initialChocolateEntry.percentCacao = 4
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}