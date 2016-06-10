//
//  ViewController.swift
//  MappingApp_MatthewTso
//
//  Created by Matthew Tso on 6/9/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var startingAddressTextField: UITextField!
    @IBOutlet var destinationAddressTextField: UITextField!
    @IBOutlet var transportationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var directionsButton: UIBarButtonItem!
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
//    var showPlacemark:CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        directionsButton.enabled = false
        
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        }

        mapView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func currentLocationButtonClick(sender: AnyObject) {
        if let location = mapView.userLocation.location {
            let span   = MKCoordinateSpanMake(0.075, 0.075)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        directionsButton.enabled = true
    }
    
    @IBAction func autofillButtonClick(sender: AnyObject) {
        startingAddressTextField.text = mapView.userLocation.title
    }
    
    @IBAction func routeButtonClick(sender: AnyObject) {
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "directionsModal" {
//            let destinationViewController = segue.destinationViewController as! DirectionsViewController
//            destinationViewController.directionSteps = self.directionSteps
//        }
//    }
    
}

