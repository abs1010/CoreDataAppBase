//
//  CompaniesEntity.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

enum Position : String, CaseIterable {
    case executive = "Executive"
    case seniorManager = "Senior Manager"
    case staff = "Staff"
}

enum CoreDataReference : String {
    case containerName = "MainDataModel"
    case company = "Company"
    case staff = "Staff"
}

enum Constants {
    enum errorTypes {
        case connectionError
        case dataCouldNotBeSaved
    }
}

struct StaffModel {
    
    var staff: [Staff]
    var isExpanded: Bool
    
    init(staff: [Staff], isExpanded: Bool) {
        self.staff = staff
        self.isExpanded = isExpanded
    }
     
}
