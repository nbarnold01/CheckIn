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

let StopLocationMonitoringNotification:String = "stopLocationMonitoring"

class CheckInViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBOutlet weak var commentContainerBottomConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var commentTextView: ExpandingTextView!
    
    var locationManager:CLLocationManager
    
    var shouldAutomaticallyMoveMap = true
    
    required init(coder aDecoder: NSCoder) {
        
        self.locationManager = CLLocationManager()

        super.init(coder: aDecoder)

    }
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        
        self.locationManager = CLLocationManager()
        
        super.init(nibName:nibNameOrNil, bundle: nibBundleOrNil)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        registerNotifications()
        
        self.mapView.layer.cornerRadius = 4
        self.commentTextView.layer.cornerRadius = 2
        
        initializeLocationManager()
        
        self.mapView.delegate = self;
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:Actions
    
    @IBAction func swippedDown(sender: UISwipeGestureRecognizer) {
        
        
        if (self.commentTextView.isFirstResponder()) {
            self.commentTextView.resignFirstResponder()
 
        }
    }
    
    //MARK:Private

    func initializeLocationManager() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        switch CLLocationManager.authorizationStatus() {
            
        case .NotDetermined :
            locationManager.requestWhenInUseAuthorization()
            
            
        case .AuthorizedWhenInUse,.AuthorizedAlways:
            locationManager.startUpdatingLocation()
            self.mapView.showsUserLocation = true
            
            
        default:
            NSLog("Location Not Authorized");
        }
    }
    
  
    func registerNotifications () {
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector:Selector(stopLocationMonitoring()),
            name: StopLocationMonitoringNotification,
            object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("keyboardWillChange:"),
            name: UIKeyboardWillShowNotification,
            object: nil)
        
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: Selector("keyboardWillChange:"),
            name:UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    func deregisterNotifications () {
     
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    

    func stopLocationMonitoring () {
        
        self.locationManager.stopMonitoringSignificantLocationChanges()
        self.mapView.showsUserLocation = false;
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
    
    
    func locationManager(manager: CLLocationManager!,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
            
            var shouldIAllow = false
            
            switch status {
                
            case .AuthorizedAlways,.AuthorizedWhenInUse :
                locationManager.startUpdatingLocation()
                
                self.mapView.showsUserLocation = true
                
            default:
                NSLog("DidChangeAuthorization: Not able to get location")
            }
    }
    
    
    //MARK:MapKit delegate
     func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
        
        
    }
    
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        var location =  userLocation.location
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
    }
    
    //MARK:UIKeyboard Methods
    
    
    func keyboardWillChange(notification:NSNotification) {
        
        var info = notification.userInfo!
        
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()

        
        let duration = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as Double
    
        
        if (notification.name == UIKeyboardWillShowNotification) {
            //raise it up
            self.commentContainerBottomConstraint.constant = keyboardFrame.size.height - self.bottomLayoutGuide.length

        } else {
            
            //snap to bottom
            self.commentContainerBottomConstraint.constant = 0

        }
        self.commentTextView.setNeedsUpdateConstraints()
        
        
        //This sucks. Perhaps it will be fixed in a new version of XCode/Swift
        let animationOptions = UIViewAnimationOptions(UInt((info[UIKeyboardAnimationCurveUserInfoKey] as NSNumber).integerValue << 16))

        
        UIView.animateWithDuration(duration,
            delay: 0.0,
            options: animationOptions,
            animations: {()in
                self.view.layoutIfNeeded()
            },completion: {(Bool)  in
                
            }
        )

    }
    
    

}

