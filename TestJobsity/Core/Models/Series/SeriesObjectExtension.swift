//
//  SeriesObjectExtension.swift
//  TestJobsity
//
//  Created by Daniel Klinkert on 8/6/19.
//  Copyright © 2019 Jobsity. All rights reserved.
//

import Foundation
import CoreData
import UIKit


extension SerieObject {
    func save(completionHandler: (_ success: Bool) -> ()) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "SerieObject", in: managedContext) else {
            return
        }
        
        let serieObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        serieObject.setValue(self.name, forKeyPath: "name")
        serieObject.setValue(self.id, forKeyPath: "id")
        serieObject.setValue(self.rating, forKeyPath: "rating")
        serieObject.setValue(self.image, forKeyPath: "image")
        
        
        do {
            try managedContext.save()
            completionHandler(true)
        } catch let error as NSError {
            completionHandler(false)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func getFavoriteSeries(completionHanlder: ResultClosure<[SerieObject]>) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest : NSFetchRequest<SerieObject> = SerieObject.fetchRequest()
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            completionHanlder(.success(results))
        } catch let error as NSError {
            completionHanlder(.failure(error))
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
    }
    
    func deleteSerie() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            managedContext.delete(self)
            try managedContext.save()
        } catch let error as NSError {
            print("No ha sido posible cargar \(error), \(error.userInfo)")
        }
    }
}
