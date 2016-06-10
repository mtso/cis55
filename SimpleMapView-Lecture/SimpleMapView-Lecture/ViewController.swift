//
//  ViewController.swift
//  SimpleMapView-Lecture
//
//  Created by Matthew Tso on 6/8/16.
//  Copyright © 2016 De Anza. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var startingAddressTextField: UITextField!
    @IBOutlet var destinationAddressTextField: UITextField!
    
    var locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    var showPlacemark:CLPlacemark?
    
    var startingAddress:String?
    var destinationAddress:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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

    @IBAction func getCurrentLocationButtonClick(sender: AnyObject) {
        startingAddress = startingAddressTextField.text
        
        geocoder.geocodeAddressString(startingAddress!, completionHandler: {
            placemarks, error in
            if error != nil {
                print(error)
                return
            }
            
            if placemarks != nil && placemarks!.count > 0 {
                let placemark = placemarks![0] as CLPlacemark
                self.showPlacemark = placemark
                
                // Add annotation
                let annotation = MKPointAnnotation()
                annotation.title = "Desired Location"
                annotation.subtitle = self.startingAddress
                annotation.coordinate = placemark.location!.coordinate
                
                self.mapView.showAnnotations([annotation], animated: true)
            }
        })
        
    }

    @IBAction func showDirectionsButtonClick(sender: AnyObject) {
        let directionRequest = MKDirectionsRequest()
        let currentTransportType:MKDirectionsTransportType = .Automobile
        var currentRoute:MKRoute?
        destinationAddress = ""
        
        // Set the source and destination of the route
        directionRequest.source = MKMapItem.mapItemForCurrentLocation()
        let destinationPlacemark = MKPlacemark(placemark: showPlacemark!)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = currentTransportType
        
        // Calculate the directions
        let directions = MKDirections(request: directionRequest) as MKDirections
        directions.calculateDirectionsWithCompletionHandler({ routeResponse, routeError in
            if routeError != nil {
                print("Error: \(routeError?.localizedDescription)")
            }
            else {
                let route = routeResponse?.routes[0] as MKRoute!
                currentRoute = route
                
                self.mapView.removeOverlays(self.mapView.overlays)
                self.mapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                
                // Scale the map
                let rect = route.polyline.boundingMapRect
                self.mapView.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
                
                // Get the route steps
                if let steps = currentRoute?.steps as [MKRouteStep]! {
                    for step in 0..<steps.count {
                        self.destinationAddress = self.destinationAddress! + steps[step].instructions
                    }
                    self.destinationAddressTextField.text = self.destinationAddress
                }
            }
        })
        
    }
    
    @IBAction func showNearbyButtonClick(sender: AnyObject) {
        let searchRequest = MKLocalSearchRequest()
        searchRequest.naturalLanguageQuery = "school"
        searchRequest.region = mapView.region
        
        let localSearch = MKLocalSearch(request: searchRequest)
        localSearch.startWithCompletionHandler({ response, error -> Void in
            
            if error != nil {
                print("Error: \(error!.localizedDescription)")
                return
            }
            
            let mapItems = response!.mapItems as [MKMapItem]
            var nearbyAnnotations:[MKAnnotation] = []
            if mapItems.count > 0 {
                for item in mapItems {
                    // Add annotation
                    
                    let annotation = MKPointAnnotation()
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    annotation.coordinate = item.placemark.location!.coordinate
                    print("\(annotation.title), \(annotation.subtitle), \(annotation.coordinate.latitude)")
                    nearbyAnnotations.append(annotation)
                }
            }
            self.mapView.showAnnotations(nearbyAnnotations, animated: true)
            
        })
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blueColor()
        renderer.lineWidth = 3
        
        return renderer
    }
}























