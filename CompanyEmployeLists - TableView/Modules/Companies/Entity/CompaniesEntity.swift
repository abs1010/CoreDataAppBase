//
//  CompaniesEntity.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

enum Position : String {
    case executive = "Executive"
    case seniorManagement = "Senior Management"
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
