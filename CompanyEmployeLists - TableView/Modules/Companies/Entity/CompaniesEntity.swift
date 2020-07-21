//
//  CompaniesEntity.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 17/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit
import CoreData

enum Position : String {
    case executive = "Executive"
    case seniorManagement = "Senior Management"
    case staff = "Staff"
}

enum CoreDataReference : String {
    case containerName = "CompanyDataModel"
    case company = "Empresa"
    case employess = "Funcionarios"
}

enum Constants {
    enum errorTypes {
        case connectionError
        case dataCouldNotBeSaved
    }
}

class CompanyCDManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataReference.containerName.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    func addCompany(name: String, image: String, description: String) {
    
        let context = persistentContainer.viewContext
        let empresa = Empresa(context: context)

        empresa.name = name

//        let passport = Passport(context: context)
//        passport.number = passportNumber

//
//        let pet = Pet(context: context)
//        pet.petName = petName

        empresa.image = image
        empresa.descrip = description
        
        try? context.save()
    }
    
    
    func loadDataFromCoreData(completion: @escaping([Empresa]) -> Void) {
        
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataReference.company.rawValue)
        let result = try? context.fetch(request)
        let arrayEmpresas = result as? [Empresa] ?? []
        completion(arrayEmpresas)
        
    }
    
    func deleteInformation(id: NSManagedObjectID, completion: (Bool) -> Void) {
        let context = persistentContainer.viewContext
        let obj = context.object(with: id)
        context.delete(obj)
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }

}
