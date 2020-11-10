//
//  Notes+CoreDataProperties.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/17/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var title: String?
    @NSManaged public var note: String?
    @NSManaged public var parentFolder: Folders

}
