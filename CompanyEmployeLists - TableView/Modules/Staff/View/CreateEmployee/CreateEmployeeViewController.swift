//
//  CreateEmployeeViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: UIViewController {
    
    let mainView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.855904758, green: 0.9211789966, blue: 0.9547855258, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    let bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let positionSegmentedControl: UISegmentedControl = {
        
        var items = [String]()
        
        Position.allCases.forEach({
            items.append($0.rawValue)
        })
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.layer.borderColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        segmentedControl.layer.borderWidth = 1.2
        segmentedControl.backgroundColor = .clear
        segmentedControl.selectedSegmentTintColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        let titleTextAttributesForSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        segmentedControl.setTitleTextAttributes(titleTextAttributesForSelected, for: .selected)
        
        return segmentedControl
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Name"
        label.textColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dobLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Birthday"
        label.textColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        
        setUp()
        setUpNavBar()
        addSubViewsAndSetConstraints()
        
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        
    }
    
    private func setUpNavBar() {
        
        navigationItem.title = "Create Employee"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(cancelCreation))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveNewEmployee))
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    private func addSubViewsAndSetConstraints() {
     
        mainView.addSubview(nameLabel)
        //mainView.addSubview(dobLabel)
        mainView.addSubview(positionSegmentedControl)
        view.addSubview(mainView)
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            
            positionSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            positionSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            positionSegmentedControl.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -10.0),
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            mainView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            mainView.heightAnchor.constraint(equalToConstant: 200.0),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            bottomView.topAnchor.constraint(equalTo: mainView.bottomAnchor, constant: 0.0),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),

            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            nameLabel.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 10.0),
            nameLabel.widthAnchor.constraint(equalToConstant: 60.0)

//            dboLabel
            
        ])
        
    }
    
    @objc private func cancelCreation() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func saveNewEmployee() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}
