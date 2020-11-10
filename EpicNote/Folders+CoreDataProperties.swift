//
//  Folders+CoreDataProperties.swift
//  EpicNote
//
//  Created by Jay Panchal on 6/17/20.
//  Copyright © 2020 Jay Panchal. All rights reserved.
//
//

import Foundation
import CoreData


extension Folders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folders> {
        return NSFetchRequest<Folders>(entityName: "Folders")
    }

    @NSManaged public var name: String
    @NSManaged public var containNotes: NSOrderedSet?

}

// MARK: Generated accessors for containNotes
extension Folders {

    @objc(insertObject:inContainNotesAtIndex:)
    @NSManaged public func insertIntoContainNotes(_ value: Notes, at idx: Int)

    @objc(removeObjectFromContainNotesAtIndex:)
    @NSManaged public func removeFromContainNotes(at idx: Int)

    @objc(insertContainNotes:atIndexes:)
    @NSManaged public func insertIntoContainNotes(_ values: [Notes], at indexes: NSIndexSet)

    @objc(removeContainNotesAtIndexes:)
    @NSManaged public func removeFromContainNotes(at indexes: NSIndexSet)

    @objc(replaceObjectInContainNotesAtIndex:withObject:)
    @NSManaged public func replaceContainNotes(at idx: Int, with value: Notes)

    @objc(replaceContainNotesAtIndexes:withContainNotes:)
    @NSManaged public func replaceContainNotes(at indexes: NSIndexSet, with values: [Notes])

    @objc(addContainNotesObject:)
    @NSManaged public func addToContainNotes(_ value: Notes)

    @objc(removeContainNotesObject:)
    @NSManaged public func removeFromContainNotes(_ value: Notes)

    @objc(addContainNotes:)
    @NSManaged public func addToContainNotes(_ values: NSOrderedSet)

    @objc(removeContainNotes:)
    @NSManaged public func removeFromContainNotes(_ values: NSOrderedSet)

}
