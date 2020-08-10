//
//  StaffModel.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 10/08/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation

struct StaffModel {
    
    var staff: [Staff]
    var isExpanded: Bool
    
    init(staff: [Staff], isExpanded: Bool) {
        self.staff = staff
        self.isExpanded = isExpanded
    }
     
}
