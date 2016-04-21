//
//  ViewController.swift
//  CIS55Lab1C_MatthewTso
//
//  Created by Matthew Tso on 4/20/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var infoToolbar: UIToolbar!
    
    let startingPayTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: 4, width: 100, height: 20))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var toolbarItems = infoToolbar.items
        
        let startingPayToolbarWidget = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        startingPayToolbarWidget.backgroundColor = UIColor.redColor()
        
//        let startingPayTitleToolbarLabel = UILabel(frame: CGRect(x: 0, y: 4, width: 100, height: 20))
        startingPayTitleToolbarLabel.font = UIFont(name: "Avenir", size: 12)
        startingPayTitleToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayTitleToolbarLabel.textColor = UIColor.grayColor()
        startingPayTitleToolbarLabel.text = "Starting Pay"
        startingPayTitleToolbarLabel.textAlignment = NSTextAlignment.Center
//        startingPayTitleToolbarLabel.clipsToBounds = false
        
        let startingPayValueToolbarLabel = UILabel(frame: CGRect(x: 0, y: 20, width: 100, height: 20))
        startingPayValueToolbarLabel.font = UIFont(name: "Avenir", size: 8)
        startingPayValueToolbarLabel.backgroundColor = UIColor.clearColor()
        startingPayValueToolbarLabel.textColor = UIColor.grayColor()
        startingPayValueToolbarLabel.text = "$0.00"
        startingPayValueToolbarLabel.textAlignment = NSTextAlignment.Center
        
        startingPayToolbarWidget.addSubview(startingPayTitleToolbarLabel)
        startingPayToolbarWidget.addSubview(startingPayValueToolbarLabel)
        
        let startingPayToolbarItem = UIBarButtonItem(customView: startingPayToolbarWidget)

        toolbarItems?.insert(startingPayToolbarItem, atIndex: 1)
        
        infoToolbar.setItems(toolbarItems, animated: false)
        
//        print(infoToolbar.frame.height)
        
        startingPayValueToolbarLabel.text = "$110.01"
        infoToolbar.setNeedsLayout()
        infoToolbar.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

