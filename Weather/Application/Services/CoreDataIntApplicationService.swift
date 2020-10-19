//
//  CoreDataIntApplicationService.swift
//  Weather
//
//  Created by Александр Кравченков on 16.10.2020.
//

import Foundation
import CoreData
import PluggableApplicationDelegate

class CoreDataIntApplicationService: NSObject, ApplicationService {

    lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CacheModel")

        container.loadPersistentStores { (descr, error) in
            print(descr)
            guard let error = error else { return }
            fatalError("Whileinitialize NSPersistentContainer an error occured: \(error)")
        }

        return container
    }()
}
