//
//  CoreDataHandler.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-08.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() ->  NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    // Saving data to CoreData
    class func saveObject(badAnswer: Int, goodAnswer: Int, goodAnswerHelp: Int, modeVerbe: String, tempsVerbe: String, verbeInfinitif: String) -> Bool {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "ItemVerbe", in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        managedObject.setValue(badAnswer, forKey: "mauvaiseReponse")
        managedObject.setValue(goodAnswer, forKey: "bonneReponse")
        managedObject.setValue(goodAnswerHelp, forKey: "bonneReponseTemps")
        managedObject.setValue(modeVerbe, forKey: "modeVerbe")
        managedObject.setValue(tempsVerbe, forKey: "tempsVerbe")
        managedObject.setValue(verbeInfinitif, forKey: "verbeInfinitif")
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    class func saveSingleObject(itemVerb: ItemVerbe) -> Bool {
        let context = getContext()
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    // FetchRequest
    class func fetchObject() -> [ItemVerbe]? {
        let context = getContext()
        var dateOfEvent: [ItemVerbe]? = nil
        do {
            dateOfEvent = try context.fetch(ItemVerbe.fetchRequest())
            return dateOfEvent
        }catch{
            return dateOfEvent
        }
    }
    // Delete a single object
    class func deleteObject(event: ItemVerbe) -> Bool {
        let context = getContext()
        context.delete(event)
        
        do {
            try context.save()
            return true
        }catch{
            return false
        }
    }
    // Delete all objects
    class func cleanDelete () -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: ItemVerbe.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch{
            return false
        }
    }
    class func filterData(searchFor: String, inAttribute: String) -> [ItemVerbe]? {
        let context = getContext()
        let fetchRequest: NSFetchRequest<ItemVerbe> = ItemVerbe.fetchRequest()
        var event: [ItemVerbe]? = nil
        let predicate = NSPredicate(format: "\(inAttribute) == %@", searchFor)
        
        fetchRequest.predicate = predicate
        
        do {
            try event = context.fetch(fetchRequest)
            return event
        }catch{
            return event
            
        }
    }
    class func filterForCompleted(searchFor: Bool, inAttribute: String) -> [ItemVerbe]? {
        let context = getContext()
        let fetchRequest: NSFetchRequest<ItemVerbe> = ItemVerbe.fetchRequest()
        var event: [ItemVerbe]? = nil
        let predicate = NSPredicate(format: "\(inAttribute) == %@", NSNumber(value: true))
        fetchRequest.predicate = predicate
        do {
            try event = context.fetch(fetchRequest)
            return event
        }catch{
            return event
            
        }
    }
    class func filterForSpecificVerb(modeVerbe: String, tempsVerbe: String) -> [ItemVerbe]? {
        let context = getContext()
        let fetchRequest: NSFetchRequest<ItemVerbe> = ItemVerbe.fetchRequest()
        var event: [ItemVerbe]? = nil
        //let predicate1 = NSPredicate(format: "infinitif == %@", infinitif)
        let predicate2 = NSPredicate(format: "modeVerbe == %@", modeVerbe)
        let predicate3 = NSPredicate(format: "tempsVerbe == %@", tempsVerbe)
        let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate2, predicate3])
        fetchRequest.predicate = predicate
        do {
            try event = context.fetch(fetchRequest)
            return event
        }catch{
            return event
        }
    }
  
}
