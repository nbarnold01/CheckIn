//
//  LocationManager.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/9/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import Foundation
import CoreLocation


class LocationManager: NSObject, CLLocationManagerDelegate {
    
  private var coreLocationManager:CLLocationManager = CLLocationManager()

    
    
    class var sharedInstance: LocationManager {
        struct Static {
            static let instance: LocationManager = LocationManager()
            
            
        }
        

        
        return Static.instance
    }
    
    
    func initialize() {
        
        NSLog("%@", "init")
    }
    
    func requestLocationPermission() {
        if (!CLLocationManager.locationServicesEnabled()) {
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//        
//        self.map.setRegion(region, animated: true)
    }
}


