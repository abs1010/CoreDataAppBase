//
//  CompaniesProtocols.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

protocol CompaniesViewToPresenterProtocol: class {
    var view: CompaniesPresenterToViewProtocol? { get set }
    var interactor: CompaniesPresenterToInteractorProtocol? { get set }
    var router: CompaniesPresenterToRouterProtocol? { get set }
    func numberOfSections() -> Int
    func numberOfRowsInSection(section: Int) -> Int
    func loadCompanieWithIndexPath(indexPath: IndexPath) -> Empresa
    func removeAllCompanyData()
    func addCompany(name: String, image: String, description: String)
    func loadInformation()
    func deleteInformation(indexPath: IndexPath)
}

protocol CompaniesPresenterToInteractorProtocol: class {
    var presenter: CompaniesInteractorToPresenterProtocol? { get set }
}

protocol CompaniesInteractorToPresenterProtocol: class {
    //func returnMovieResults(movieHeader: MovieHeader)
    //func problemOnFetchingData(error: Constants.errorTypes)
}

protocol CompaniesPresenterToViewProtocol: class {
    var presenter: CompaniesViewToPresenterProtocol? { get set }
    func showResults()
    func showProblem(error: Constants.errorTypes)
    func confirmationOfDeletion()
}

protocol CompaniesPresenterToRouterProtocol: class {
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController
}
