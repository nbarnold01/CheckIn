//
//  CheckIn.swift
//  CheckIn
//
//  Created by Nathan Arnold on 3/24/15.
//  Copyright (c) 2015 Nathan Arnold. All rights reserved.
//

import Foundation
import CoreData
@objc(CheckIn)
class CheckIn: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var longitude: NSNumber
    @NSManaged var latitude: NSNumber
    @NSManaged var note: String

}
