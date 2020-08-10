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
    private var didSeparateSections = false
    private var staffArray: [StaffModel]? = []
    
    var selectedCompany: Company? {
        
        didSet {
            
            DispatchQueue.main.async {
                self.separateArrayIntoSections()
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
    
    private func separateArrayIntoSections() {
        
        if let section0 = selectedCompany?.staff?.filter({ $0.position == Position.executive.rawValue }) {
            
            staffArray?.append(StaffModel(staff: section0, isExpanded: false))
            
        }
        
        if let section1 = selectedCompany?.staff?.filter({ $0.position == Position.seniorManager.rawValue }) {
            
            staffArray?.append(StaffModel(staff: section1, isExpanded: false))
            
        }
        
        if let section2 = selectedCompany?.staff?.filter({ $0.position == Position.staff.rawValue }) {
            
            staffArray?.append(StaffModel(staff: section2, isExpanded: false))
            
        }
        
        didSeparateSections = true
        
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        tableView.separatorStyle = .none
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
    
    private func closeSection(position: Position, section: Int) {
        
        let qtde = selectedCompany?.staff?.filter({$0.position == position.rawValue}).count ?? 0
        
        let arrowTouched = staffArray?[section].isExpanded
        
        var indexPaths = [IndexPath]()
        
        var row = 0
        
        while row < qtde {
            indexPaths.append(IndexPath(row: row, section: section))
            row += 1
        }
        
        staffArray?[section].staff.removeAll()
        tableView.deleteRows(at: indexPaths, with: .fade)
        
        staffArray?[section].isExpanded = !(arrowTouched ?? false)
        
    }
    
    @objc private func didTapOnArrow(sender: UIButton) {
        
        let section = sender.tag
        let openClose = staffArray?[section].isExpanded
        
        staffArray?[section].isExpanded = !openClose!
        
        switch section {
        case 0:
            closeSection(position: .executive, section: section)
            
        case 1:
            closeSection(position: .seniorManager, section: section)
        
        case 2:
            closeSection(position: .staff, section: section)
            
        default:
            return
        }
        
        tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .top)
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: .zero)
        headerView.backgroundColor = #colorLiteral(red: 0.9491223693, green: 0.9485244155, blue: 0.9693283439, alpha: 1)
        
        let label = UILabel()
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        headerView.addSubview(label)
        
        let button = UIButton()
        if didSeparateSections {
            let option = self.staffArray?[section].isExpanded
            let image = option ?? false ? #imageLiteral(resourceName: "seta_baixo_preto") : #imageLiteral(resourceName: "seta_cima_preto")
            button.setImage(image, for: .normal)
        }
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = section
        button.addTarget(self, action: #selector(didTapOnArrow(sender:)), for: .touchUpInside)
        headerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            button.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            button.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20)
        ])
        
        switch section {
        case 0:
            label.text = Position.executive.rawValue
        case 1:
            label.text = Position.seniorManager.rawValue
        case 2:
            label.text = Position.staff.rawValue
        default:
            label.text = "Header"
        }
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return .init(40.0)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return Position.allCases.count
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if didSeparateSections {
            return staffArray?[section].staff.count ?? 0
        }else {
            return 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellID)
        
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
            return cell
        }
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        cell.detailTextLabel?.text = formatDate.string(from: employee?.dateOfBirth ?? Date())
        cell.textLabel?.text = employee?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
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
