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
//////////////////////////////
//// MARK: Struct to assign the right pronom
//////////////////////////////
struct Personne{
    let verbArray: VerbeFrancais
    var first: String{
        let firstLetter = verbArray.premier.characters.first
        if firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "é" || firstLetter == "è"{
            if verbArray.mode == "subjonctif"{
                return "que j'"
            }else {return "j'"}
        }else{
            if verbArray.mode == "subjonctif"{
                return "que je"
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
        }else{
            return "ils"
        }
    }

}
////////////////////////////////////
// MARK: Structs to assign the right example and description
///////////////////////////////////
struct ContexteVerbe {
    let verbArray: VerbeFrancais
    var contexte: [String] {
        if verbArray.mode == "indicatif"{
            if verbArray.temps == "Présent"{
                return ["Maintenant, nous 'devons' attendre l’autobus.", "Un exemple avec 'devoir'."]
            }else if verbArray.temps == "Imparfait"{
                return ["Il 'allait' tous les jours au même endroit.", "Un exemple avec 'aller'."]
            }else if verbArray.temps == "Passé composé"{
                return ["Ce matin, je suis allé chez le coiffeur", "Un exemple avec 'aller'."]
            }else if verbArray.temps == "Futur simple"{
                return ["Demain, nous 'irons' à la campagne.", "Un exemple avec 'aller'."]
            }else if verbArray.temps == "Passé simple"{
                return ["Il 'arriva' à l’improviste et je fus surpris de le voir.", "Un exemple avec 'arriver'. *Note: le passé simple est utiliser en littérature, presque pas oralement"]
            }else if verbArray.temps == "Plus-que-parfait"{
                return ["Si j’avais su, j’'aurais étudié' plus longtemps.", "Un exemple avec 'étudier'."]
            }else if verbArray.temps == "Futur antérieur"{
                return ["Cette année 'aura été' un échec.", "Un exemple avec 'être'."]
            }else if verbArray.temps == "Passé antérieur"{
                return ["Dès qu’il 'eut fini' le spectacle il quitta la scène.", "Un exemple avec 'finir'."]
            }
        }else if verbArray.mode == "subjonctif"{
            if verbArray.temps == "Passé"{
                return ["Je n’ai pas aimé qu’il 'soit parti'.", "Un exemple avec 'partir'."]
            }else if verbArray.temps == "Présent"{
                return ["Je veux que ce soit une règle", "Un exemple avec 'être'."]
            }else if verbArray.temps == "Imparfait"{
                return ["Il voulu qu’il 'allât' à l’université.", "Un exemple avec 'aller.  *Note: ce temps de verbe n'est pas utilisé oralement"]
            }else if verbArray.temps == "Plus-que-parfait"{
                return ["Il eut été bien que j''eusse su' cela avant", "Un exemple avec 'savoir'. *Note: ce temps de verbe n'est pas utilisé oralement"]
            }
        }else if verbArray.mode == "conditionnel"{
            if verbArray.temps == "Présent"{
                return ["Nous 'serions' heureux que vous veniez avec nous.", "Un exemple avec 'être'."]
            }else if verbArray.temps == "Passé"{
                return ["Si tu avais écouté les conseils tu 'aurais réussi'.", "Un exemple avec 'réussir'."]
            }
        }else if verbArray.mode == "Impératif"{
            if verbArray.temps == "présent"{
                return ["'Viens' avec nous.", "Un exemple avec 'venir'."]
            }else if verbArray.temps == "Passé"{
                return ["'Ayez fini' vos devoirs à temps.", "Un exemple avec 'finir'."]
            }

        }
        return self.contexte
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
        let firstLetter =  String(word.characters.prefix(1)).capitalized
        let otherLetters = String(word.characters.dropFirst())
        return(firstLetter + otherLetters)
    }
}

