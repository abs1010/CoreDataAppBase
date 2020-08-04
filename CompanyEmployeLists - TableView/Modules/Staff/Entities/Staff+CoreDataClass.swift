//
//  Staff+CoreDataClass.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//
//

import Foundation
import CoreData

public class Staff: NSManagedObject {
    
    convenience init(name: String, dob: Date, position: Position) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        ///Calls the Designated initializer
        self.init(entity: Staff.entity(), insertInto: context)
     
        self.name = name
        self.dateOfBirth = dob
        self.position = position.rawValue
        
    }

}
