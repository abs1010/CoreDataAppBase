//
//  CreateEmployeeViewController.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CreateEmployeeViewController: UIViewController {
    
    private let headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.855904758, green: 0.9211789966, blue: 0.9547855258, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    private let bottomView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let positionSegmentedControl: UISegmentedControl = {
        
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
    
    private let nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Name"
        label.textColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Type the name"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 2
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = false
        
        return textField
    }()
    
    private let dobLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.text = "Birthday"
        label.textColor = #colorLiteral(red: 0.03102667071, green: 0.1788176596, blue: 0.2500987947, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let datePicker = UIDatePicker()
    
    private let dobTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "DD/MM/AAAA"
        textField.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        textField.layer.cornerRadius = 2
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clipsToBounds = false
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .green
        // Do any additional setup after loading the view.
        
        setUp()
        setUpNavBar()
        addSubViewsAndSetConstraints()
        createdatepicker()
        
    }
    
    private func createdatepicker() {
        
        datePicker.datePickerMode = .date
        
        let tollbar = UIToolbar()
        tollbar.sizeToFit()
        
        let donebutton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        tollbar.setItems([donebutton], animated: true)
        dobTextField.inputAccessoryView = tollbar
        
        dobTextField.inputView = datePicker
        
    }
    
    @objc private func done() {
        
        let formatDate = DateFormatter()
        formatDate.dateFormat = "dd/MM/yyyy"
        
        dobTextField.text = formatDate.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    private func setUp() {
        
        view.backgroundColor = #colorLiteral(red: 0.9796836972, green: 0.2490850687, blue: 0.3219926953, alpha: 1)
        nameTextField.delegate = self
        dobTextField.delegate = self
        
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
     
        headerView.addSubview(nameLabel)
        headerView.addSubview(nameTextField)
        headerView.addSubview(dobLabel)
        headerView.addSubview(dobTextField)
        headerView.addSubview(positionSegmentedControl)
        view.addSubview(headerView)
        view.addSubview(bottomView)
        
        NSLayoutConstraint.activate([
            
            positionSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            positionSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10.0),
            positionSegmentedControl.topAnchor.constraint(equalTo: dobTextField.bottomAnchor, constant: 10.0),
            
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
            headerView.bottomAnchor.constraint(equalTo: positionSegmentedControl.bottomAnchor, constant: 10.0),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0.0),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0.0),
            bottomView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0.0),
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            
            nameLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10.0),
            nameLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15.0),
            nameLabel.widthAnchor.constraint(equalToConstant: 80.0),
            
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10.0),
            nameTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10.0),
            nameTextField.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10.0),

            dobLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0),
            dobLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20.0),
            dobLabel.widthAnchor.constraint(equalToConstant: 80.0),

            dobTextField.leadingAnchor.constraint(equalTo: dobLabel.trailingAnchor, constant: 10.0),
            dobTextField.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10.0),
            dobTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10.0)
            
        ])
        
    }
    
    @objc private func cancelCreation() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    @objc private func saveNewEmployee() {
        
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension CreateEmployeeViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == dobTextField {
            textField.text?.removeAll()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextField {
            dobTextField.becomeFirstResponder()
        }
        
        return true
    }
    
}

/*
 /First StackView
 let stackView1 = UIStackView(arrangedSubviews: [nameLabel, nameTextField])
 stackView1.translatesAutoresizingMaskIntoConstraints = false
 stackView1.axis = .horizontal
 stackView1.setCustomSpacing(10.0, after: mainView)
 
 mainView.addSubview(stackView1)
*/
