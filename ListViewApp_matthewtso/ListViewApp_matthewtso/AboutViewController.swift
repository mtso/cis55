//
//  AboutViewController.swift
//  ListViewApp_matthewtso
//
//  Created by Matthew Tso on 5/6/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
//import QuartzCore

class AboutViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var backgroundTop1: NSLayoutConstraint!
    @IBOutlet var backgroundTop2: NSLayoutConstraint!
    @IBOutlet var aboutContentView: UIView!
    @IBOutlet var aboutHeaderView: UIView!
    @IBOutlet var aboutHeaderViewBottom: NSLayoutConstraint!
    @IBOutlet var aboutImageView: UIImageView!
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        gradient.frame = CGRect(x: aboutHeaderView.bounds.origin.x, y: aboutHeaderView.bounds.origin.y, width: view.bounds.width, height: aboutHeaderView.bounds.height)
        
        gradient.colors = [
            UIColor(red: 0.09, green: 0.08, blue: 0.08, alpha: 0).CGColor,
            UIColor(red: 0.09, green: 0.08, blue: 0.08, alpha: 0.1).CGColor,
            UIColor(red: 0.09, green: 0.08, blue: 0.08, alpha: 1).CGColor
        ]
        gradient.locations = [0.0, 0.15, 1.0]
        
        aboutHeaderView.layer.insertSublayer(gradient, atIndex: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.clipsToBounds = true
        let firstBackgroundOffset = -scrollView.contentOffset.y * 0.5
        let secondBackgroundOffset = -scrollView.contentOffset.y * 1.3        
        
        backgroundTop1.constant = firstBackgroundOffset
        backgroundTop2.constant = secondBackgroundOffset
        
        
        let topOfHeader = aboutContentView.frame.origin.y - aboutHeaderView.frame.height
        
        if (scrollView.contentOffset.y > topOfHeader) {
            aboutHeaderViewBottom.constant = -scrollView.contentOffset.y + topOfHeader
            aboutHeaderView.backgroundColor = UIColor(red: 0.09, green: 0.08, blue: 0.08, alpha: 1)
        } else {
            aboutHeaderViewBottom.constant = 0
            aboutHeaderView.backgroundColor = UIColor(red: 0.09, green: 0.08, blue: 0.08, alpha: 0)
        }
        
        let percent = scrollView.contentOffset.y / topOfHeader
        aboutImageView.alpha = percent < 1 ? 1 - (1 * percent) : 0
    }
    
    @IBAction func websiteButtonClick(sender: AnyObject) {
        // UIAlertView is deprecated now, so use UIAlertController instead.
        
        let alert = UIAlertController(title: NSLocalizedString("Open Safari?", comment: ""), message: "", preferredStyle: .Alert)
        alert.modalPresentationStyle = .Popover
        
        let action = UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .Default) { action in
            let url = NSURL(string: "https://matthewtso.com/")!
            UIApplication.sharedApplication().openURL(url)
        }
        let cancel = UIAlertAction(title: NSLocalizedString("No", comment: ""), style: .Cancel) { action in
        }
        alert.addAction(cancel)
        alert.addAction(action)
        
        if let presenter = alert.popoverPresentationController {
            let button = sender as! UIView
            presenter.sourceView = button;
            presenter.sourceRect = button.bounds;
        }
        
        presentViewController(alert, animated: true, completion: nil)
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