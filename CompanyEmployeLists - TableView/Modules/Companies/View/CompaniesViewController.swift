//
//  ViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 15/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CompaniesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let cellId = "cellID"
    
    let companiesTableView = UITableView(frame: .zero)
    
    weak var presenter: CompaniesViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpNavBar()
        setUp()
        setUpConstraints()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
        companiesTableView.delegate = self
        companiesTableView.dataSource = self
        
        companiesTableView.register(CompaniesTableViewCell.self, forCellReuseIdentifier: cellId)
        
        companiesTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(companiesTableView)
        
    }
    
    private func setUpNavBar() {
        
        navigationItem.title = "Companies"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        
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
        
    }
    
    @objc private func addCompany() {
        
        let alerta = UIAlertController(title: "Adicionar empresa", message: "Digite o nome da empresa.", preferredStyle: .alert)
    
        alerta.addTextField { (textField) in
            
            textField.placeholder = "Enter Company Name"
                  
        }
        
        let btnOk = UIAlertAction(title: "Ok", style: .default) { ( _) in
            
            let firstTextField = alerta.textFields![0] as UITextField
            
            let company = Empresa()
            company.name = firstTextField.text ?? ""
            company.image = "add"
            company.descrip = "Nova empresa adicionada"
            
            let funcionario = Funcionarios()
            funcionario.name = "Alan"
            funcionario.birthDate = "20/02/1990"
            funcionario.position = ""
            
            company.funcionarios = funcionario
            
            self.presenter?.addCompany(company)
            
            self.companiesTableView.reloadData()
        }
        
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
    
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //
    //        return "🏢 Names"
    //
    //    }
    
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
        
        guard let company = presenter?.loadCompanieWithIndexPath(indexPath: indexPath) else {
            return UITableViewCell()
        }
        
        //cell.companyImageView.image = UIImage(named: company.image)
        
        //cell.companyName.text = company.description == "" ? company.name : company.name + " - " + company.description
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let eViewController = EmployeeViewController()
        
        let company = presenter?.loadCompanieWithIndexPath(indexPath: indexPath)
        
        eViewController.selectedCompany = company
        
        navigationController?.pushViewController(eViewController, animated: true)
        
    }
    
}

extension CompaniesViewController : CompaniesPresenterToViewProtocol {
    
    func confirmationOfDeletion() {
        
        let alerta = UIAlertController(title: "Aviso", message: "Todos os dados foram removidos!", preferredStyle: .alert)
        
        let btnOk = UIAlertAction(title: "Ok", style: .default) { ( _) in
            self.companiesTableView.reloadData()
        }
        
        alerta.addAction(btnOk)
        
        present(alerta, animated: true)
        
    }
    
    func showResults() {
        
    }
    
}

