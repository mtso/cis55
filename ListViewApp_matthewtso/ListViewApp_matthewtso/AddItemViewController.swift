//
//  AddItemViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/30/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import CoreData

class AddItemViewController: UIViewController {

    @IBOutlet var addName: UITextField!
    @IBOutlet var addImageName: UITextField!
    @IBOutlet var addTaste: UITextField!
    @IBOutlet var addOrigin: UITextField!
    
    var newChocolateEntry: ChocolateEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "saveSegue" {
            let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
            
            newChocolateEntry = NSEntityDescription.insertNewObjectForEntityForName("ChocolateEntry", inManagedObjectContext: managedObjectContext) as! ChocolateEntry
            
            newChocolateEntry.name = addName.text
            newChocolateEntry.imageName = addImageName.text
            newChocolateEntry.taste = addTaste.text
            newChocolateEntry.origin = addOrigin.text
            newChocolateEntry.percentCacao = 4
            
            do {
                try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
    }


}