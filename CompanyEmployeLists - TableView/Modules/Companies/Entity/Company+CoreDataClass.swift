//
//  Company+CoreDataClass.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//
//

import Foundation
import CoreData

public class Company: NSManagedObject {
    
    var staff: [Staff]? {
        return self.staffArray?.array as? [Staff]
    }
    
    convenience init(name: String, image: String, description: String) {
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        self.init(entity: Company.entity(), insertInto: context)
        
        self.name = name
        self.image = image
        self.descrip = description
        
    }
    
}
