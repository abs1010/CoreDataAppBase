//
//  CompaniesTableViewCell.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CompaniesTableViewCell: UITableViewCell {
    
    let companyImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = img.frame.height / 2
        img.clipsToBounds = false
        return img
    }()

    let companyName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
        setUpConstrainsts()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setUp() {
    
        addSubview(companyImageView)
        addSubview(companyName)
        
    }
    
    private func setUpConstrainsts() {
        
        NSLayoutConstraint.activate([
            companyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            companyImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0),
            companyImageView.trailingAnchor.constraint(equalTo: companyImageView.leadingAnchor, constant: 5.0),
            companyImageView.widthAnchor.constraint(equalToConstant: 30),
            companyImageView.heightAnchor.constraint(equalToConstant: 30),
            
            companyName.leadingAnchor.constraint(equalTo: companyImageView.trailingAnchor, constant: 5.0),
            companyName.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
}
