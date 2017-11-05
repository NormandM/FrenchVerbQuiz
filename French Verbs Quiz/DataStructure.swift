//
//  DataStructure.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import CoreData

//MARK: Verbe structure
struct VerbeFrancais{
    let verbe: String
    let mode: String
    let temps: String
    let premier: String
    let deuxieme: String
    let troisieme: String
    let quatrieme: String
    let cinquieme: String
    let sixieme: String
    var verbeChoisi = [String]()
    let n: Int
    init(verbArray: [[String]], n: Int){
        self.n = n
        verbeChoisi = verbArray[n]
        mode = verbeChoisi[0]
        temps = verbeChoisi[1]
        verbe = verbeChoisi[2]
        premier = verbeChoisi[3]
        deuxieme = verbeChoisi[4]
        troisieme = verbeChoisi[5]
        quatrieme = verbeChoisi[6]
        cinquieme = verbeChoisi[7]
        sixieme = verbeChoisi[8]
    }
}
struct VerbeTrie {
    let verbe: String
    let mode: String
    let temps: String
    let verbeConjugue: String
    let personne: String
    let n: Int
    init(allInfoList: [[String]], n: Int){
        self.n = n
        mode = allInfoList[n][0]
        temps = allInfoList[n][1]
        verbe = allInfoList[n][2]
        verbeConjugue = allInfoList[n][3]
        personne = allInfoList[n][4]
    }
}
//////////////////////////////
//// MARK: Struct to assign the right pronom
//////////////////////////////
struct Personne{
    let verbArray: VerbeFrancais
    var first: String{
        //let firstLetter = verbArray.premier.characters.first
        let firstLetter = verbArray.premier.first
        if firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "é" || firstLetter == "è"{
            if verbArray.mode == "subjonctif"{
                return "que j'"

            }else {return "j'"}
        }else{
            if verbArray.mode == "subjonctif"{
                return "que je"
            }else if verbArray.mode == "impératif"{
                return ""
            }else {return "je"}
        }
    }
    var second: String{
        if verbArray.mode == "subjonctif"{
            return "que tu"
        }else if verbArray.mode == "impératif"{
            return"(tu)"
        }else{
            return "tu"
        }
    }
    var third: String {
        if verbArray.mode == "subjonctif"{
            return "qu'il"
        }else if verbArray.mode == "impératif"{
            return ""
        }else{
            return "il"
        }
    }
    var fourth: String{
        if verbArray.mode == "subjonctif"{
            return "que nous"
        }else if verbArray.mode == "impératif"{
            return"(nous)"
        }else{
            return "nous"
        }
    }
    var fifth: String{
        if verbArray.mode == "subjonctif"{
            return "que vous"
        }else if verbArray.mode == "impératif"{
            return"(vous)"
        }else{
            return "vous"
        }
    }
    var sixth: String {
        if verbArray.mode == "subjonctif"{
            return "qu'ils"
        }else if verbArray.mode == "impératif"{
            return ""
        }else{
            return "ils"
        }
    }

}

struct PersonneTrie {
    let verbeTrie: VerbeTrie
    var first: String{
        var firstReturn = ""
        if verbeTrie.personne == "1" {
            let firstLetter = verbeTrie.verbeConjugue.first
            if firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "é" || firstLetter == "è"{
                if verbeTrie.mode == "subjonctif"{
                    firstReturn = "que j'"
                }else {return "j'"}
            }else{
                if verbeTrie.mode == "subjonctif"{
                    firstReturn = "que je"
                }else if verbeTrie.mode == "impératif"{
                    firstReturn = ""
                }else {firstReturn = "je"}
            }
        }
        return firstReturn
    }
    var second: String{
        var secondReturn = ""
        if verbeTrie.personne == "2" {
            if verbeTrie.mode == "subjonctif"{
                secondReturn = "que tu"
            }else if verbeTrie.mode == "impératif"{
                secondReturn = "(tu)"
            }else{
                secondReturn = "tu"
            }
        }
        return secondReturn
    }
    var third: String {
        var thirdReturn = ""
        if verbeTrie.personne == "3" {
            if verbeTrie.mode == "subjonctif"{
                thirdReturn = "qu'il"
            }else if verbeTrie.mode == "impératif"{
                thirdReturn = ""
            }else{
                thirdReturn = "il"
            }
        }
        return thirdReturn
    }
    var fourth: String{
        var fourthReturn = ""
        if verbeTrie.personne == "4" {
            if verbeTrie.mode == "subjonctif"{
                fourthReturn = "que nous"
            }else if verbeTrie.mode == "impératif"{
                fourthReturn = "(nous)"
            }else{
                fourthReturn = "nous"
            }
        }
        return fourthReturn
    }
    var fifth: String{
        var fifthReturn = ""
        if verbeTrie.personne == "5" {
            if verbeTrie.mode == "subjonctif"{
                fifthReturn = "que vous"
            }else if verbeTrie.mode == "impératif"{
                fifthReturn = "(vous)"
            }else{
                fifthReturn = "vous"
            }
        }
        return fifthReturn
    }
    var sixth: String {
        var sixthReturn = ""
        if verbeTrie.personne == "6" {
            if verbeTrie.mode == "subjonctif"{
                sixthReturn = "qu'ils"
            }else if verbeTrie.mode == "impératif"{
                sixthReturn = ""
            }else{
                sixthReturn = "ils"
            }
        }
        return sixthReturn
    }


}

/////////////////////////////////////
// MARK: CoreData data controller, persistent store etc
/////////////////////////////////////
open class DataController: NSObject {
    
    static let sharedInstance = DataController()
    
    fileprivate override init() {}
    
    fileprivate lazy var applicationDocumentDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[(urls.endIndex - 1)]
    }()
    
    fileprivate lazy var managerObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "VerbesFrancais", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managerObjectModel)
        let url = self.applicationDocumentDirectory.appendingPathComponent("VerbesFrancais.sqlite")
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            let userInfo: [String: AnyObject] = [NSLocalizedDescriptionKey: "Failed to initialized the application's saved data" as AnyObject, NSLocalizedFailureReasonErrorKey: "There was an error creating or loading the application's saved data" as AnyObject, NSUnderlyingErrorKey: error as NSError]
            let wrappedError = NSError(domain: "Normand", code: 9999, userInfo: userInfo)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }()
    
    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    open func saveContext() {
        if managedObjectContext.hasChanges{
            do {
                try managedObjectContext.save()
            } catch let error as NSError{
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
////////////////////////////////
// MARK: helper function to capitalisez first letter of string
///////////////////////////////
class Helper {
    func capitalize(word: String) -> (String) {
        let firstLetter =  String(word.prefix(1)).capitalized
        let otherLetters = String(word.dropFirst())
        return(firstLetter + otherLetters)
    }
}

