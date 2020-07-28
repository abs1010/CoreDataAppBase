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
    
    //lazy var coreDataManager = CoreDataManager()
    
    var companyArray: [Company] = []
    
    func numberOfSections() -> Int {
        
        return 1
        
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        
        return companyArray.count
        
    }
    
    func loadCompanieWithIndexPath(indexPath: IndexPath) -> Company {
        
        return companyArray[indexPath.row]
        
    }
    
    func removeAllCompanyData() {
        
        companyArray.removeAll()
        view?.confirmationOfDeletion()
        
    }
    
    func addCompany(name: String, image: String, description: String) {

        CoreDataManager.shared.addCompany(name: name, image: image, description: description)
        
        refreshCoreData()
        view?.showResults()
        
    }
    
    func refreshCoreData() {

         CoreDataManager.shared.loadDataFromCoreData { (loadedData) in
            
            self.companyArray = loadedData
            
            self.view?.showResults()
            
        }

    }
    
    func deleteInformation(indexPath: IndexPath) {
        
        let index =  companyArray[indexPath.row].objectID
        
        CoreDataManager.shared.deleteACompany(id: index) { (success) in
            
            if success {
                view?.confirmationOfDeletion()
                refreshCoreData()
            }else {
                view?.showProblem(error: .dataCouldNotBeSaved)
            }
            
        }
        
    }
    
}

