//
//  ViewController.swift
//  PerspectiveScrollView
//
//  Created by Matthew Tso on 4/26/16.
//  Copyright © 2016 DeAnza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewTrailingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView.image = UIImage(named: "darkmap")
        
        let myView: UIView = scrollView//.subviews[0]
        let layer: CALayer = myView.layer
        var rotationAndPerspectiveTransform: CATransform3D = CATransform3DIdentity
        rotationAndPerspectiveTransform.m34 = 1.0 / -500
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, CGFloat(55.0 * M_PI / 180.0), 1.0, 0.0, 0.0)
        layer.transform = rotationAndPerspectiveTransform
        
        view.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func updateMinZoomScaleForSize(size: CGSize) {
        let imageWidth = imageView.image?.size.width
        let imageHeight = imageView.image?.size.height
        
        let widthScale = scrollView.bounds.size.width / imageWidth!
        let heightScale = scrollView.bounds.size.height / imageHeight!
        
        let minScale = max(widthScale, heightScale)

        scrollView.minimumZoomScale = minScale
        
        print(minScale)
        
        scrollView.zoomScale = minScale
    }
    
    private func updateConstraintsForSize(size:CGSize) {
        //!! Need to figure out how to center the image.
        
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewTopConstraint.constant = yOffset
        imageViewBottomConstraint.constant = yOffset
        
        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewLeadingConstraint.constant = xOffset
        imageViewTrailingConstraint.constant = xOffset
        
        view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateMinZoomScaleForSize(scrollView.bounds.size)
        updateConstraintsForSize(scrollView.bounds.size)

    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return imageView
    }

    
    func scrollViewDidZoom(scrollView: UIScrollView) {
        updateConstraintsForSize(scrollView.bounds.size)
    }
    
}
