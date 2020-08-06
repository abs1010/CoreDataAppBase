//
//  EmployeeViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class StaffViewController: UITableViewController {
    
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
        setUpNavBar()
        
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
    }
    
    private func setUpNavBar() {
        
        navigationItem.title = selectedCompany?.name
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addStaff))
        
    }
    
    @objc private func addStaff() {
        
        let vc = CreateEmployeeViewController()
        
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return Position.executive.rawValue
        case 1:
            return Position.seniorManager.rawValue
        case 2:
            return Position.staff.rawValue
        default:
            return "Header"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return .init(40.0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return Position.allCases.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let exec = selectedCompany?.staff?.filter({$0.position == Position.executive.rawValue}).count else { return 0 }
        guard let senior = selectedCompany?.staff?.filter({$0.position == Position.seniorManager.rawValue}).count else { return 0 }
        guard let staff = selectedCompany?.staff?.filter({$0.position == Position.staff.rawValue}).count else { return 0 }
        
        switch section {
        case 0:
            return exec
        case 1:
            return senior
        case 2:
            return staff
        default:
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        
        var employee: Staff?
        //let employee = selectedCompany?.staff?[indexPath.row]
        
        switch indexPath.section {
        case 0:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.executive.rawValue}) {
                employee = executives[indexPath.row]
            }
        case 1:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.seniorManager.rawValue}) {
                employee = executives[indexPath.row]
            }
        case 2:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.staff.rawValue}) {
                employee = executives[indexPath.row]
            }
        default:
            return cell
        }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = formatDate.string(from: employee?.dateOfBirth ?? Date())
        cell.textLabel?.text = employee?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //selectedCompany?.removeFromStaffArray(at: indexPath.row)
        //CoreDataManager.shared.saveContext()
        
        var employee: Staff?
        
        switch indexPath.section {
        case 0:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.executive.rawValue}) {
                employee = executives[indexPath.row]
            }
        case 1:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.seniorManager.rawValue}) {
                employee = executives[indexPath.row]
            }
        case 2:
            if let executives = selectedCompany?.staff?.filter({$0.position == Position.staff.rawValue}) {
                employee = executives[indexPath.row]
            }
        default:
            return
        }
        
        if let staff = employee {
            selectedCompany?.removeFromStaffArray(staff)
            CoreDataManager.shared.saveContext()
        }
        
        tableView.deleteRows(at: [indexPath], with: .fade)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

extension StaffViewController: CreateEmployeeViewControllerDelegate {
    
    func saveStaff(staff: Staff) {
        
        self.selectedCompany?.addToStaffArray(staff)
        CoreDataManager.shared.saveContext()
        
        navigationController?.popViewController(animated: true)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
}
