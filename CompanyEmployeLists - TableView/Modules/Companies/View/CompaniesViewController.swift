//
//  ViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 15/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import CoreData

class CompaniesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let cellId = "cellID"
    
    private let companiesTableView = UITableView(frame: .zero)
    
    weak var presenter: CompaniesViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpNavBar()
        setUp()
        setUpConstraints()
        
        presenter?.refreshCoreData()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? StaffViewController, let indexPath = companiesTableView.indexPathForSelectedRow {
            
            destination.selectedCompany = presenter?.loadCompanieWithIndexPath(indexPath: indexPath)
            
        }
        
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        
        companiesTableView.register(CompaniesTableViewCell.self, forCellReuseIdentifier: cellId)
        
        companiesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companiesTableView)
        
    }
    
    private func setUpNavBar() {
        
        navigationItem.title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetList))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCompany))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc private func resetList() {
        
        presenter?.removeAllCompanyData()
        
        //Do not delete from CoreData for now...
        
    }
    
    @objc private func addCompany() {
        
        let alerta = UIAlertController(title: "Adicionar empresa", message: "Digite as informações da empresa.", preferredStyle: .alert)
        
        alerta.addTextField { (nameTextField) in
            
            nameTextField.placeholder = "Enter Company Name"
            
        }
        
        alerta.addTextField { (imageTextField) in
            
            imageTextField.placeholder = "Company image Name"
            
        }
        
        alerta.addTextField { (descriptionTextField) in
            
            descriptionTextField.placeholder = "Description"
            
        }
        
        let btnOk = UIAlertAction(title: "Ok", style: .default) { ( _) in
            
            guard let nameTextField = alerta.textFields![0].text else { return }
            guard let imageTextField = alerta.textFields![1].text else { return }
            guard let descriptionTextField = alerta.textFields![2].text else { return }
            
            self.presenter?.addCompany(name: nameTextField, image: imageTextField, description: descriptionTextField
                
        )}
        
        alerta.addAction(btnOk)
        
        present(alerta, animated: true)
        
    }
    
    private func setUpConstraints() {
        
        NSLayoutConstraint.activate([
            companiesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            companiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            companiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            companiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
    }
    
    //MARK : Table View Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let companyImageView: UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = img.frame.height / 2
            img.clipsToBounds = false
            img.image = UIImage(named: "avatar")
            
            return img
        }()
        
        let label = UILabel()
        label.text = "Names"
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let containerView = UIView()
        containerView.backgroundColor = #colorLiteral(red: 0.9491223693, green: 0.9485244155, blue: 0.9693283439, alpha: 1)
        
        containerView.addSubview(companyImageView)
        containerView.addSubview(label)
        
        companyImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        companyImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10.0).isActive = true
        companyImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        companyImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        label.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 10.0).isActive = true
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        
        return containerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return .init(45.0)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return presenter?.numberOfRowsInSection(section: section) ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CompaniesTableViewCell
        
        cell.accessoryType = .disclosureIndicator
        
        guard let company = presenter?.loadCompanieWithIndexPath(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        if let image = company.image {
            cell.companyImageView.image = UIImage(named: image)
        }
        
        cell.companyName.text = company.name
        
        cell.companyDescription.text = company.descrip
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let eViewController = StaffViewController()
        
        let company = presenter?.loadCompanieWithIndexPath(indexPath: indexPath)
        
        eViewController.selectedCompany = company
        
        navigationController?.pushViewController(eViewController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        presenter?.deleteInformation(indexPath: indexPath)
        
    }
    
}

extension CompaniesViewController : CompaniesPresenterToViewProtocol {
    
    func confirmationOfDeletion() {
        
        AlertService.shared.showAlert(image: #imageLiteral(resourceName: "exclamation-mark"), title: "Aviso", message: "Os dados da empresa foram removidos!") {
            //self.companiesTableView.reloadData()
        }
        
    }
    
    func showResults() {
        
        DispatchQueue.main.async {
            self.companiesTableView.reloadData()
        }
        
    }
    
    func showProblem(error: Constants.errorTypes) {
        
        print("Problema ao remover os dados")
        
    }
    
}

