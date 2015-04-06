//
//  TripViewController.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/24/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import UIKit
import Foundation
import CoreData
import CoreLocation


class TripViewController: UITableViewController,NSFetchedResultsControllerDelegate {


    
    var fetchedResultsController: NSFetchedResultsController {
        
        
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        
        let managedObjectContext = CoreDataHelper.sharedInstance.managedObjectContext!
        
        
        
        /* `NSFetchRequest` config
        fetch all `Checkin`s
        order them descending by date
        at least one sort order _is_ required */
        
        let entity = NSEntityDescription.entityForName(NSStringFromClass(CheckIn), inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "date", ascending: false)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    
    var _fetchedResultsController: NSFetchedResultsController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK:TableViewDataSource Methods

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("blandCell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let info = self.fetchedResultsController.sections![section] as NSFetchedResultsSectionInfo
        return info.numberOfObjects
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as CheckIn
            cell.textLabel?.text = item.note
    }
    
    //MARK:TableViewDelegate Methods
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("showMapView", sender: self);

        
    }
    
    
    //MARK:NSFetchedResutlsController Delegate Methods
    
    // fetched results controller delegate
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(controller: NSFetchedResultsController,
        didChangeObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath)
                self.configureCell(cell!, atIndexPath: indexPath)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            case .Move:
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Delete:
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            default:
                return
            }
    }
    
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "showMapView") {
            let controller = segue.destinationViewController as MapViewController
            
            
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                
                let item = self.fetchedResultsController.objectAtIndexPath(indexPath) as CheckIn
                
                controller.focusedLocation = CLLocation(latitude: item.latitude.doubleValue, longitude: item.longitude.doubleValue)
                
            }
        
        }

    }
    

}
