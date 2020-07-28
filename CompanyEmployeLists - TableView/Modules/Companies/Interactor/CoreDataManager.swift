//
//  CoreDataManager.swift
//  CompanyEmployeLists - TableView
//
//  Created by Alan Silva on 27/07/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static var shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataReference.containerName.rawValue)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext() {
        
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Loading Information from Core Data
    func loadDataFromCoreData(completion: @escaping([Company]) -> Void) {
       
        let context = persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreDataReference.company.rawValue)
        let result = try? context.fetch(request)
        let arrayEmpresas = result as? [Company] ?? []
        completion(arrayEmpresas)
        
    }
    
    // MARK: - Add a Company to Core Data
    func addCompany(name: String, image: String, description: String) {
    
        let context = persistentContainer.viewContext
        let empresa = Company(context: context)

        empresa.name = name
        empresa.image = image
        empresa.descrip = description
        
        saveContext()

    }
    
    // MARK: - Delete a Company to Core Data
    func deleteACompany(id: NSManagedObjectID, completion: (Bool) -> Void) {
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
    
    /*
    mutating func addEmployeeToACompany(employee: Funcionario, id: NSManagedObjectID) {
        
        let context = persistentContainer.viewContext
        
        let empresa = Empresa(context: context)

        let funcionario = context.object(with: id) as? Funcionario
        
        //funcionario.add
        
        //person?.addToVehicles(car)
        
        try? context.save()
        
    }
 */

    
}
