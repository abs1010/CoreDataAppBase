//
//  Company+CoreDataProperties.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var descrip: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var staffArray: NSOrderedSet?

}

// MARK: Generated accessors for staffArray
extension Company {

    @objc(insertObject:inStaffArrayAtIndex:)
    @NSManaged public func insertIntoStaffArray(_ value: Staff, at idx: Int)

    @objc(removeObjectFromStaffArrayAtIndex:)
    @NSManaged public func removeFromStaffArray(at idx: Int)

    @objc(insertStaffArray:atIndexes:)
    @NSManaged public func insertIntoStaffArray(_ values: [Staff], at indexes: NSIndexSet)

    @objc(removeStaffArrayAtIndexes:)
    @NSManaged public func removeFromStaffArray(at indexes: NSIndexSet)

    @objc(replaceObjectInStaffArrayAtIndex:withObject:)
    @NSManaged public func replaceStaffArray(at idx: Int, with value: Staff)

    @objc(replaceStaffArrayAtIndexes:withStaffArray:)
    @NSManaged public func replaceStaffArray(at indexes: NSIndexSet, with values: [Staff])

    @objc(addStaffArrayObject:)
    @NSManaged public func addToStaffArray(_ value: Staff)

    @objc(removeStaffArrayObject:)
    @NSManaged public func removeFromStaffArray(_ value: Staff)

    @objc(addStaffArray:)
    @NSManaged public func addToStaffArray(_ values: NSOrderedSet)

    @objc(removeStaffArray:)
    @NSManaged public func removeFromStaffArray(_ values: NSOrderedSet)

}
