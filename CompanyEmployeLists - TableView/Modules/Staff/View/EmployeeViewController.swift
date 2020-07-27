//
//  EmployeeViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class EmployeeViewController: UITableViewController {
    
    private var cellID = "cellID"
    
    var selectedCompany: Company? {
        
        didSet {
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Employees"
        
        setUp()
        
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //Todo
//        if selectedCompany?.employees.filter({$0.position == .executive}).count ?? 0 > 0 {
//
//            return Position.executive.rawValue
//
//        }
//
//        else if selectedCompany?.employees.filter({$0.position == .seniorManagement}).count ?? 0 > 0 {
//
//            return Position.seniorManagement.rawValue
//
//        }
//        else if selectedCompany?.employees.filter({$0.position == .staff}).count ?? 0 > 0 {
//
//            return Position.staff.rawValue
//
//        }else {
//
            return "Header"
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return .init(30.0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
//        guard let exec = selectedCompany?.employees.filter({$0.position == .executive}) else { return 0 }
//        guard let senior = selectedCompany?.employees.filter({$0.position == .seniorManagement}) else { return 0 }
//        guard let staff = selectedCompany?.employees.filter({$0.position == .staff}) else { return 0 }
        
//        let array = [exec, senior, staff]
//
//        var qtdeSections = 0
//
//        array.forEach { (position) in
//            if position.count > 0 {
//                qtdeSections += 1
//            }
//        }
//
//        return qtdeSections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        switch section {
//        case 0:
//            return selectedCompany?.employees.filter({ (employee) -> Bool in
//                employee.position == .executive
//            }).count ?? 0
//        case 1:
//            return selectedCompany?.employees.filter({ (employee) -> Bool in
//                employee.position == .seniorManagement
//            }).count ?? 0
//        case 2:
//            return selectedCompany?.employees.filter({ (employee) -> Bool in
//                employee.position == .staff
//            }).count ?? 0
//        default:
//            return 0
//        }
        
        return 1
        //return selectedCompany?.employees.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        //var employee: Funcionario?
        
//        switch indexPath.section {
//        case 0:
//            employee = selectedCompany?.employees.filter({$0.position == .executive})[indexPath.row]
//        case 1:
//            employee = selectedCompany?.employees.filter({$0.position == .seniorManagement})[indexPath.row]
//        case 2:
//            employee = selectedCompany?.employees.filter({$0.position == .staff})[indexPath.row]
//        default:
//            break
//        }
        
        //cell.textLabel?.text = employee?.name
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}
