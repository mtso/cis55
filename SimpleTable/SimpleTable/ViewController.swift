//
//  ViewController.swift
//  SimpleTable
//
//  Created by Matthew Tso on 4/13/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
        "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso",
        "Upstate", "Traif", "Graham Avenue Meats And Deli", "Waffle & Wolf", "Five Leaves",
        "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return restaurantNames.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let name = restaurantNames[indexPath.row]
        let imageNameComponents = name.componentsSeparatedByCharactersInSet(NSCharacterSet.letterCharacterSet().invertedSet)
        let imageName = imageNameComponents.joinWithSeparator("").lowercaseString

        cell.textLabel?.text = name
        
        if (UIImage(named: imageName) != nil){
            
        } else {
            cell.imageView?.image = UIImage(named: "restaurant")
        }
        
        return cell
    }

}

