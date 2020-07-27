//
//  Staff+CoreDataProperties.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//
//

import Foundation
import CoreData


extension Staff {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Staff> {
        return NSFetchRequest<Staff>(entityName: "Staff")
    }

    @NSManaged public var name: String?
    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var position: String?
    @NSManaged public var company: Company?

}
