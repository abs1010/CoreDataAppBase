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
    
    lazy var coreDataManager = CompanyCDManager()
    
    var companyArray: [Empresa] = []
    
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
    
    func addCompany(name: String, image: String, description: String) {

        coreDataManager.addCompany(name: name, image: image, description: description)
        
        loadInformation()
        view?.showResults()
        
    }
    
    func loadInformation() {

        coreDataManager.loadDataFromCoreData { (loadedData) in
            
            self.companyArray = loadedData
            
            self.view?.showResults()
            
        }

    }
    
    func deleteInformation(indexPath: IndexPath) {
        
        let index =  companyArray[indexPath.row].objectID
        
        coreDataManager.deleteInformation(id: index) { (success) in
            
            if success {
                view?.confirmationOfDeletion()
                loadInformation()
            }else {
                view?.showProblem(error: .dataCouldNotBeSaved)
            }
            
        }
        
    }
    
}

