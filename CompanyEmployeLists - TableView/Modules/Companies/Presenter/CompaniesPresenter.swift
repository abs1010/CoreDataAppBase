//
//  File.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CompaniesPresenter: CompaniesViewToPresenterProtocol, CompaniesInteractorToPresenterProtocol {

    var view: CompaniesPresenterToViewProtocol?
    var interactor: CompaniesPresenterToInteractorProtocol?
    var router: CompaniesPresenterToRouterProtocol?
    
    let coreDataManager = CoreDataManager()
    
    var companyArray: [Empresa] = []
    
/*
    var companyArray = [
        Company(name: "Apple", image: "apple", description: "Founded: Apr 01, 1976", employees: [
            Employee(name: "Steve Jobs", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Alan", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Carlos", birthDate: "20/02/1957", position: .seniorManagement),
            Employee(name: "Amanda", birthDate: "20/02/1957", position: .seniorManagement),
            Employee(name: "Jaqueline", birthDate: "20/02/1957", position: .seniorManagement),
            Employee(name: "Caio", birthDate: "20/02/1957", position: .seniorManagement),
            Employee(name: "Adriana", birthDate: "20/02/1957", position: .seniorManagement),
            Employee(name: "Rosana", birthDate: "20/02/1957", position: .staff),
            Employee(name: "Alexandro", birthDate: "20/02/1957", position: .staff),
            Employee(name: "Camila", birthDate: "20/02/1957", position: .staff)]),
        Company(name: "Facebook", image: "facebook", description: "Founded: Fev 04, 2004", employees: [
            Employee(name: "Mark Zuckenberg", birthDate: "20/02/1957", position: .executive),
            Employee(name: "James", birthDate: "04/12/1963", position: .executive),
            Employee(name: "Robert", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Juddit", birthDate: "04/12/1963", position: .executive),
            Employee(name: "Smith", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Tommy", birthDate: "04/12/1963", position: .executive),
            Employee(name: "Michelle", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Rosita", birthDate: "04/12/1963", position: .staff)]),
        Company(name: "Google", image: "google", description: "Founded: Sep 04, 1998", employees: [
            Employee(name: "Swaniac", birthDate: "20/02/1957", position: .executive),
            Employee(name: "Gable", birthDate: "04/12/1963", position: .executive),
            Employee(name: "Melania", birthDate: "15/09/1975", position: .executive),
            Employee(name: "Estenia", birthDate: "15/09/1975", position: .seniorManagement),
            Employee(name: "Enuomic", birthDate: "15/09/1975", position: .executive),
            Employee(name: "Yves", birthDate: "15/09/1975", position: .seniorManagement),
            Employee(name: "Tamic", birthDate: "15/09/1975", position: .staff),
            Employee(name: "Bounds", birthDate: "15/09/1975", position: .seniorManagement),
            Employee(name: "Ana", birthDate: "15/09/1975", position: .executive),
            Employee(name: "Rodrigo", birthDate: "15/09/1975", position: .executive),
            Employee(name: "EKeley", birthDate: "15/09/1975", position: .staff)]),
        Company(name: "Microsoft", image: "microsoft", description: "", employees: [
            Employee(name: "Bill Gates", birthDate: "15/09/1975", position: .executive)]),
        Company(name: "Tesla", image: "tesla", description: "", employees: [
            Employee(name: "Elon Musk", birthDate: "15/09/1975", position: .seniorManagement)]),
        Company(name: "Twitter", image: "twitter", description: "", employees: []),
        Company(name: "Uber", image: "uber", description: "", employees: [
            Employee(name: "Uber usk", birthDate: "15/09/1999", position: .seniorManagement)])]
     */
    
    func numberOfSections() -> Int {
        
        return 1
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        return companyArray.count
        
    }
    
    func loadCompanieWithIndexPath(indexPath: IndexPath) -> Empresa {
        
        return companyArray[indexPath.row]
        
    }
    
    func removeAllCompanyData() {
        
        companyArray.removeAll()
        view?.confirmationOfDeletion()
        
    }
    
    func addCompany(_ company: Empresa) {
        
        guard let name = company.name else { return }
        guard let image = company.image else { return }
        guard let description = company.descrip else { return }
        
        coreDataManager.addCompany(name: name, image: image, description: description)
        
        companyArray.append(company)
        
    }
    
    func loadInformation() {

        coreDataManager.loadDataFromCoreData { (loadedData) in
            
            self.companyArray = loadedData
            
        }

    }
    
}

