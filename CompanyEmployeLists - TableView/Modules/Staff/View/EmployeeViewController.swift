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
    private var arrowTouched = false
    
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
    
    @objc private func didTapOnArrow(sender: UIButton) {
        
        arrowTouched = !arrowTouched
        
        let image = arrowTouched ? #imageLiteral(resourceName: "seta_cima_preto") : #imageLiteral(resourceName: "seta_baixo_preto")

        print("Clicou em \(sender.tag)")
        
        let indexPaths: [IndexPath] = [IndexPath(row: 0, section: 0), IndexPath(row: 1, section: 0)]
        
        tableView.deleteRows(at: indexPaths, with: .fade)
    
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
        button.setImage(#imageLiteral(resourceName: "seta_cima_preto"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tag = section
        headerView.addSubview(button)
        
        button.addTarget(self, action: #selector(didTapOnArrow(sender:)), for: .touchUpInside)
        
        //
//        let image = UIImageView()
//        image.image = UIImage(named: "seta_cima_preto")!
//        image.contentMode = .scaleAspectFit
//        image.translatesAutoresizingMaskIntoConstraints = false
//        headerView.addSubview(image)
        
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
        
        guard let exec = selectedCompany?.staff?.filter({$0.position == Position.executive.rawValue}).count else { return 0 }
        guard let senior = selectedCompany?.staff?.filter({$0.position == Position.seniorManager.rawValue}).count else { return 0 }
        guard let staff = selectedCompany?.staff?.filter({$0.position == Position.staff.rawValue}).count else { return 0 }
        
        switch section {
        case 0:
            return arrowTouched ? 0 : exec 
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
