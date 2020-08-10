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
        
        //let company = Company()
        
        //print(company.staffArray?.array.count)
        
        companyArray.removeAll()
        view?.confirmationOfDeletion()
        
    }
    
    fileprivate enum validationError: Error {
        
        case emptyOrInvalidName
        case emptyImage
        case emptyDescription
        
        var errorDescription: String? {
            
            switch self {
            case .emptyOrInvalidName:
                return "The name field cannot be empty."
            case .emptyImage:
                return "The Date Of Birth field is not valid."
            case .emptyDescription:
                return "You have entered an invalid description."
            }
            
        }
        
    }
    
    private func validadeFields(name: String, image: String, description: String) throws {
        
        guard name != "" else {
            throw validationError.emptyOrInvalidName
        }
        
        guard image != "" else {
            throw validationError.emptyImage
        }
        
        guard description.count > 2 else {
            throw validationError.emptyDescription
        }
        
    }
    
    func addCompany(name: String, image: String, description: String) {
        
        do {
            
            try validadeFields(name: name, image: image, description: description)
            
            CoreDataManager.shared.addCompany(name: name, image: image, description: description)
            
            refreshCoreData()
            view?.showResults()
            
        }
        catch validationError.emptyOrInvalidName {
            
            if let message = validationError.emptyOrInvalidName.errorDescription {
                
                AlertService.shared.showAlert(image: #imageLiteral(resourceName: "Error"), title: "Erro", message: String.init(repeating: message, count: 1), completion: {
                    
                })

            }
            
        }
        catch validationError.emptyImage {
            
            if let message = validationError.emptyImage.errorDescription {
                
                AlertService.shared.showAlert(image: #imageLiteral(resourceName: "Error"), title: "Erro", message: String.init(repeating: message, count: 1), completion: {
                    
                })

            }
            
        }
        catch validationError.emptyDescription {
            
            if let message = validationError.emptyDescription.errorDescription {
                
                AlertService.shared.showAlert(image: #imageLiteral(resourceName: "Error"), title: "Erro", message: String.init(repeating: message, count: 1), completion: {
                    
                })

            }
            
        }
        catch {
            
        }
        
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

