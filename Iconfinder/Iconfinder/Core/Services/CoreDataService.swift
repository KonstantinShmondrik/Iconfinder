//
//  CoreDataService.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 10.08.2024.
//

import CoreData

class CoreDataService {

    enum DatabaseName: String {

        case icons = "IconsDataBase"
    }

    private let databaseName: DatabaseName

    init(databaseName: DatabaseName) {
        self.databaseName = databaseName
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: databaseName.rawValue)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                dump("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()

    private var context: NSManagedObjectContext { persistentContainer.viewContext }

    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                dump("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func create<T: NSManagedObject>(isSaveRequired: Bool, completion: (T) -> Void) {
        let object = T(context: context)
        completion(object)

        if isSaveRequired {
            saveContext()
        }
    }

    func object<T: NSManagedObject>(
        with predicate: NSPredicate,
        prefetchingRelationships: [String]? = nil
    ) throws -> T? {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate

        if let prefetchingRelationships = prefetchingRelationships {
            request.relationshipKeyPathsForPrefetching = prefetchingRelationships
        }

        let result = try context.fetch(request)
        return result.first
    }

    func update<T: NSManagedObject>(with predicate: NSPredicate, completion: (T) -> Void) throws {
        guard let object: T = try object(with: predicate) else { return }
        completion(object)
        saveContext()
    }

    func all<T: NSManagedObject>(
        with predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil
    ) throws -> [T] {
        let request: NSFetchRequest<T> = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.returnsObjectsAsFaults = false

        let result = try context.fetch(request)
        return result
    }

    func delete<T: NSManagedObject>(object: T, isSaveNeeded: Bool = true) {
        context.delete(object)
        saveContext()
    }

    func deleteAll<T: NSManagedObject>(type: T.Type) throws {
        let objects: [T] = try all()
        objects.forEach { delete(object: $0) }
    }

    func recreateDatabase() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        
        do {
            let coordinator = persistentContainer.persistentStoreCoordinator
            context.reset()
            
            try coordinator.destroyPersistentStore(at: url, ofType: NSSQLiteStoreType, options: nil)
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
            context.reset()
        } catch {
            dump(error)
        }
    }
}
