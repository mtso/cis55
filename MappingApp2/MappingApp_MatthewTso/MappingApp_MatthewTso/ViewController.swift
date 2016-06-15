//
//  ViewController.swift
//  MappingApp_MatthewTso
//
//  Created by Matthew Tso on 6/9/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var startingAddressTextField: UITextField!
    @IBOutlet var destinationAddressTextField: UITextField!
    @IBOutlet var transportationTypeSegmentedControl: UISegmentedControl!
    @IBOutlet var routeButton: UIButton!
    @IBOutlet var directionsButton: UIBarButtonItem!
    @IBOutlet var routeActivityIndicator: UIActivityIndicatorView!
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    var directionSteps = [String]()
    var startingAddressText = ""
    var destinationAddressText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.requestWhenInUseAuthorization()
        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            mapView.showsUserLocation = true
        }
        
        mapView.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange", name: UITextFieldTextDidChangeNotification, object: startingAddressTextField)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidChange", name: UITextFieldTextDidChangeNotification, object: destinationAddressTextField)
        
        routeButton.enabled = false
        directionsButton.enabled = false
        routeActivityIndicator.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func autofillButtonClick(sender: AnyObject) {
        startingAddressTextField.text = mapView.userLocation.title
    }
    
    @IBAction func swapButtonClick(sender: AnyObject) {
        let temporaryAddress = startingAddressTextField.text
        startingAddressTextField.text = destinationAddressTextField.text
        destinationAddressTextField.text = temporaryAddress
    }

    @IBAction func routeButtonClick(sender: AnyObject) {
        /* == Routing procedure ==
         * Separate each geocoder process into its own method because
         * each geocoder must finish before using returned placemarks
         * for requesting directions from MapKit.
         */
        
        routeActivityIndicator.startAnimating()
        routeActivityIndicator.hidden = false
        
        if startingAddressTextField.text == "Current Location" {
            let source = MKMapItem.mapItemForCurrentLocation()
            
            findDestinationAndRoute(source)
        } else {
            let startingAddress = startingAddressTextField.text
            
            // Start geocoder for starting address
            geocoder.geocodeAddressString(startingAddress!, completionHandler: {
                (placemarks: [CLPlacemark]?, error: NSError?) in
                if error != nil {
                    print(error)
                    return
                }

                if placemarks != nil && placemarks!.count > 0 {
                    let placemark = placemarks![0] as CLPlacemark
                    let source = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                    
                    self.findDestinationAndRoute(source)
                }
            })
        }
    }
    
    func findDestinationAndRoute(source: MKMapItem) {
        if self.destinationAddressTextField.text == "Current Location" {
            let destination = MKMapItem.mapItemForCurrentLocation()
            
            self.findRoute(source: source, destination: destination)
        } else {
            let destinationAddress = self.destinationAddressTextField.text
            
            // Start geocoder for destination address
            self.geocoder.geocodeAddressString(destinationAddress!, completionHandler: {
                (placemarks: [CLPlacemark]?, error: NSError?) in
                if error != nil {
                    print(error)
                    return
                }
                
                if placemarks != nil && placemarks!.count > 0 {
                    let placemark = placemarks![0] as CLPlacemark
                    let destination = MKMapItem(placemark: MKPlacemark(placemark: placemark))
                    
                    self.findRoute(source: source, destination: destination)
                }
            })
        }
    }
    
    func findRoute(source source: MKMapItem, destination: MKMapItem) {
        var currentTransportType: MKDirectionsTransportType!
        switch (transportationTypeSegmentedControl.selectedSegmentIndex) {
        case 0:
            currentTransportType = .Automobile
        case 1:
            currentTransportType = .Walking
        case 2:
            currentTransportType = .Transit
        default:
            currentTransportType = .Any
        }
        
        let directionRequest = MKDirectionsRequest()
        var currentRoute:MKRoute?
        
        // Set the source and destination of the route
        directionRequest.source = source
        directionRequest.destination = destination
        directionRequest.transportType = currentTransportType
        
        // Calculate the directions
        let directions = MKDirections(request: directionRequest) as MKDirections
        directions.calculateDirectionsWithCompletionHandler({ routeResponse, routeError in
            if routeError != nil {
                print("Error: \(routeError?.localizedDescription)")
                
                self.routeActivityIndicator.stopAnimating()
                self.routeActivityIndicator.hidden = true
            }
            else {
                let route = routeResponse?.routes[0] as MKRoute!
                currentRoute = route
                
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                
                // Scale the map
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                
                self.directionSteps.removeAll()
                // Get the route steps
                if let steps = currentRoute?.steps as [MKRouteStep]! {
                    for step in steps {
                        self.directionSteps.append(step.instructions)
                    }
                }
                
                self.directionsButton.enabled = true
                
                self.routeActivityIndicator.stopAnimating()
                self.routeActivityIndicator.hidden = true
                
                self.startingAddressTextField.text = source.name
                self.destinationAddressTextField.text = destination.name
                self.startingAddressText = source.name!
                self.destinationAddressText = destination.name!
            }
        })
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        renderer.lineWidth = 3
        
        return renderer
    }
    
    @IBAction func currentLocationButtonClick(sender: AnyObject) {
        if let location = mapView.userLocation.location {
            let span   = MKCoordinateSpanMake(0.075, 0.075)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @IBAction func done(segue: UIStoryboardSegue) {
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "directionsModal" {
            let destinationViewController = segue.destinationViewController as! DirectionsViewController
            destinationViewController.directionSteps = directionSteps
            
            let startingAddress = startingAddressText
            let destinationAddress = destinationAddressText
            destinationViewController.title = startingAddress + " to " + destinationAddress
        }
    }
    
    func textFieldDidChange() {
        if startingAddressTextField.text?.characters.count > 0 && destinationAddressTextField.text?.characters.count > 0 {
            routeButton.enabled = true
        } else {
            routeButton.enabled = false
        }
    }
}

