//
//  SecondViewController.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/4/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import QuartzCore


class CheckInViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var commentTextView: UITextView!
    
    var locationManager:CLLocationManager!
    
    var shouldAutomaticallyMoveMap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mapView.layer.cornerRadius = 4
        self.commentTextView.layer.cornerRadius = 2
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
//        if (!CLLocationManager.locationServicesEnabled()) {
            locationManager.requestWhenInUseAuthorization()
//        }
        
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: UICollectionView Datasource and delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
  
       
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("imageCell", forIndexPath: indexPath) as UICollectionViewCell
        
        cell.backgroundColor = UIColor.greenColor()
        // Configure the cell
        return cell
        
        
    }
    
    //MARK: UICollectionView Delegate
    
    //MARK: CLLocationManager Delegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let location = locations.last as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001))
        
//        self.mapView.setRegion(region, animated: true)
    }
    

//    
//    
//    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
//        locationManager.stopUpdatingLocation()
//        if (error) {
//            if (seenError == false) {
//                seenError = true
//                print(error)
//            }
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
//        if (locationFixAchieved == false) {
//            locationFixAchieved = true
//            var locationArray = locations as NSArray
//            var locationObj = locationArray.lastObject as CLLocation
//            var coord = locationObj.coordinate
//            
//            println(coord.latitude)
//            println(coord.longitude)
//        }
//    }
//    
//    func locationManager(manager: CLLocationManager!,
//        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
//            var shouldIAllow = false
//            
//            switch status {
//            case CLAuthorizationStatus.Restricted:
//                locationStatus = "Restricted Access to location"
//            case CLAuthorizationStatus.Denied:
//                locationStatus = "User denied access to location"
//            case CLAuthorizationStatus.NotDetermined:
//                locationStatus = "Status not determined"
//            default:
//                locationStatus = "Allowed to location Access"
//                shouldIAllow = true
//            }
//            NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
//            if (shouldIAllow == true) {
//                NSLog("Location to Allowed")
//                // Start location services
//                locationManager.startUpdatingLocation()
//            } else {
//                NSLog("Denied access: \(locationStatus)")
//            }
    
    //MARK:MapKit delegate
     func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        
        
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var location =  userLocation.location
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
    }


    
    
}

