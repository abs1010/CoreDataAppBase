//
//  CompaniesRouter.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class CompaniesRouter : CompaniesPresenterToRouterProtocol {
    
    static func createModule(as presentationStyle: UIModalPresentationStyle) -> UIViewController {
        
        let view = CompaniesViewController()
        
        view.modalPresentationStyle = presentationStyle
        
        let presenter: CompaniesViewToPresenterProtocol & CompaniesInteractorToPresenterProtocol = CompaniesPresenter()
        let interactor: CompaniesPresenterToInteractorProtocol = CompaniesIteractor()
        let router: CompaniesPresenterToRouterProtocol = CompaniesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
}
