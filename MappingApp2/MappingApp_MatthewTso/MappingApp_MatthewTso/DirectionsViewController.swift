//
//  DirectionsViewController.swift
//  MappingApp_MatthewTso
//
//  Created by Matthew Tso on 6/9/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit

class DirectionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var directionSteps: [String]?
    @IBOutlet var titleBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleBarButtonItem.enabled = false
        titleBarButtonItem.title = self.title
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directionSteps!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "directionStepCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        
        let text = directionSteps?[indexPath.row]
        
        cell.textLabel?.text = text
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
