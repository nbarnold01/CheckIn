//
//  MapViewController.swift
//  CheckIn
//
//  Created by Nathan Arnold on 4/6/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var focusedLocation:CLLocation?
    
    var focusedPin:MKAnnotation?
    
    var pinnedLocations:Array<CLLocationCoordinate2D>
    
    @IBOutlet weak var mapView: MKMapView!
    
    required init(coder aDecoder: NSCoder) {
        
        pinnedLocations = []
        
        super.init(coder: aDecoder)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if let location = self.focusedLocation {

            
            let center = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)

            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: false)
            

        }
        
    }
    
    
    
    
    
}