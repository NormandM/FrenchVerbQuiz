//
//  StatistiqueTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-11.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData

class StatistiqueTableViewController: UITableViewController {
    @IBOutlet weak var remettreAZero: UIBarButtonItem!
    
    var itemFinal: [[String]] = []
    
    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: ItemVerbe.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verbeInfinitif", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        return request
    }()
    
    let sectionListe = ["INDICATIF", "SUBJONCTIF", "CONDITIONNEL", "IMPÉRATIF"]
    let itemInitial = [["Présent", "Imparfait", "Passé composé", "Futur simple", "Passé simple", "Plus-que-parfait", "Futur antérieur", "Passé antérieur"], ["Présent", "Passé", "Imparfait", "Plus-que-parfait"], ["Présent", "Passé"], ["Présent", "Passé"]]

    var items: [ItemVerbe] = []

    enum TempsDeVerbe: String {
        case présent = "indicatifPrésent"
        case imparfait = "indicatifImparfait"
        case passé = "indicatifPassé composé"
        case passéSimple = "indicatifPassé simple"
        case passéAntérieur = "indicatifPassé antérieur"
        case futurSimple = "indicatifFutur simple"
        case plusQueParfait = "indicatifPlus-que-parfait"
        case futurAntérieur = "indicatifFutur antérieur"
        case subjonctifPrésent = "subjonctifPrésent"
        case subjonctifPassé = "subjonctifPassé"
        case subjonctifImparfait = "subjonctifImparfait"
        case subjonctifPlusQueParfait = "subjonctifPlus-que-parfait"
        case conditionnelPrésent = "conditionnelPrésent"
        case conditionnelPassé = "conditionnelPassé"
        case impératifPrésent = "impératifPrésent"
        case impératifPassé = "impératifPassé"
    
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 151/255, green: 156/255, blue: 159/255, alpha: 1.0) //make the background color light blue
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Statistiques du Quiz"
        populateData()
 
     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionListe[section]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionListe.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInitial[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
 
        cell.textLabel?.text = self.itemFinal[indexPath.section][indexPath.row]
        return cell
    }
//////////////////////////////////////
// MARK: All Buttons and actions
//////////////////////////////////////

     @IBAction func remettreAZero(_ sender: UIBarButtonItem) {
        remettreAZero.tintColor = UIColor.black
        do {
            let items = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                managedObjectContext.delete(item)
            }
            try managedObjectContext.save()
            
        } catch {
            // Error Handling
            // ...
        }

            populateData()
            tableView.reloadData()
            // Save Changes

    }
////////////////////////////////////////////
// MARK: ALL FUNCTIONS
///////////////////////////////////////////
    func populateData() {
        var indicatifprésentP: String = ""
        var indicatifimparfaitP: String = ""
        var indicatifpassécomposéP: String = ""
        var indicatifpassésimpleP: String = ""
        var indicatifpasséantérieurP: String = ""
        var indicatiffutursimpleP: String = ""
        var indicatifplusqueparfaitP: String = ""
        var indicatiffuturantérieurP: String = ""
        var subjonctifprésentP: String = ""
        var subjonctifpasséP: String = ""
        var subjonctifimparfaitP: String = ""
        var subjonctifplusqueparfaitP: String = ""
        var conditionnelprésentP: String = ""
        var conditionnelpasséP: String = ""
        var impératifprésentP: String = ""
        var impératifpasséP: String = ""
        var indicatifprésentB: Int = 0
        var indicatifprésentM: Int = 0
        var indicatifimparfaitB: Int = 0
        var indicatifimparfaitM: Int = 0
        var indicatifpassécomposéB: Int = 0
        var indicatifpassécomposéM: Int = 0
        var indicatifpassésimpleB: Int = 0
        var indicatifpassésimpleM: Int = 0
        var indicatifpasséantérieurB: Int = 0
        var indicatifpasséantérieurM: Int = 0
        var indicatiffutursimpleB: Int = 0
        var indicatiffutursimpleM: Int = 0
        var indicatifplusqueparfaitB: Int = 0
        var indicatifplusqueparfaitM: Int = 0
        var indicatiffuturantérieurB: Int = 0
        var indicatiffuturantérieurM: Int = 0
        var subjonctifprésentB: Int = 0
        var subjonctifprésentM: Int = 0
        var subjonctifpasséB: Int = 0
        var subjonctifpasséM: Int = 0
        var subjonctifimparfaitB: Int = 0
        var subjonctifimparfaitM: Int = 0
        var subjonctifplusqueparfaitB: Int = 0
        var subjonctifplusqueparfaitM: Int = 0
        var conditionnelprésentB: Int = 0
        var conditionnelprésentM: Int = 0
        var conditionnelpasséB: Int = 0
        var conditionnelpasséM: Int = 0
        var impératifprésentB: Int = 0
        var impératifprésentM: Int = 0
        var impératifpasséB: Int = 0
        var impératifpasséM: Int = 0


        do {
            items = try managedObjectContext.fetch(fetchRequest) as! [ItemVerbe]
        }catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
        for item in items {
            if let tempVerbe = TempsDeVerbe(rawValue: (item.modeVerbe! + item.tempsVerbe!)){
                switch tempVerbe {
                case .présent:
                    indicatifprésentB = indicatifprésentB + Int(item.bonneReponse)
                    indicatifprésentM = indicatifprésentM + Int(item.mauvaiseReponse)
                case .conditionnelPassé:
                    conditionnelpasséB = conditionnelpasséB + Int(item.bonneReponse)
                    conditionnelpasséM = conditionnelpasséM + Int(item.mauvaiseReponse)
                case .conditionnelPrésent:
                    conditionnelprésentB = conditionnelprésentB + Int(item.bonneReponse)
                    conditionnelprésentM = conditionnelprésentM + Int(item.mauvaiseReponse)
                case .futurAntérieur:
                    indicatiffuturantérieurB = indicatiffuturantérieurB + Int(item.bonneReponse)
                    indicatiffuturantérieurM = indicatiffuturantérieurM + Int(item.mauvaiseReponse)
                case .futurSimple:
                    indicatiffutursimpleB = indicatiffutursimpleB + Int(item.bonneReponse)
                    indicatiffutursimpleM = indicatiffutursimpleM + Int(item.mauvaiseReponse)
                case .imparfait:
                    indicatifimparfaitB = indicatifimparfaitB + Int(item.bonneReponse)
                    indicatifimparfaitM = indicatifimparfaitM + Int(item.mauvaiseReponse)
                case .impératifPassé:
                    impératifpasséB = impératifpasséB + Int(item.bonneReponse)
                    impératifpasséM = impératifpasséM + Int(item.mauvaiseReponse)
                case .impératifPrésent:
                    impératifprésentB = impératifprésentB + Int(item.bonneReponse)
                    impératifprésentM = impératifprésentM + Int(item.mauvaiseReponse)
                case .passé:
                    indicatifpassécomposéB = indicatifpassécomposéB + Int(item.bonneReponse)
                    indicatifpassécomposéM = indicatifpassécomposéM + Int(item.mauvaiseReponse)
                case .passéAntérieur:
                    indicatifpasséantérieurB = indicatifpasséantérieurB + Int(item.bonneReponse)
                    indicatifpasséantérieurM = indicatifpasséantérieurM + Int(item.mauvaiseReponse)
                case .passéSimple:
                    indicatifpassésimpleB = indicatifpassésimpleB + Int(item.bonneReponse)
                    indicatifpassésimpleM = indicatifpassésimpleM + Int(item.mauvaiseReponse)
                case .plusQueParfait:
                    indicatifplusqueparfaitB = indicatifplusqueparfaitB + Int(item.bonneReponse)
                    indicatifplusqueparfaitM = indicatifplusqueparfaitM + Int(item.mauvaiseReponse)
                case .subjonctifImparfait:
                    subjonctifimparfaitB = subjonctifimparfaitB + Int(item.bonneReponse)
                    subjonctifimparfaitM = subjonctifimparfaitM + Int(item.mauvaiseReponse)
                case .subjonctifPassé:
                    subjonctifpasséB = subjonctifpasséB + Int(item.bonneReponse)
                    subjonctifpasséM = subjonctifpasséM + Int(item.mauvaiseReponse)
                case .subjonctifPlusQueParfait:
                    subjonctifplusqueparfaitB = subjonctifplusqueparfaitB + Int(item.bonneReponse)
                    subjonctifplusqueparfaitM = subjonctifplusqueparfaitM + Int(item.mauvaiseReponse)
                case .subjonctifPrésent:
                    subjonctifprésentB = subjonctifprésentB + Int(item.bonneReponse)
                    subjonctifprésentM = subjonctifprésentM + Int(item.mauvaiseReponse)
                }
            }
            
        }
        indicatifprésentP = "Présent: " + pourcentage(bonne: indicatifprésentB, mauvaise: indicatifprésentM)
        indicatifimparfaitP = "Imparfait: " + pourcentage(bonne: indicatifimparfaitB, mauvaise: indicatifimparfaitM)
        indicatifpassécomposéP = "Passé composé: " + pourcentage(bonne: indicatifpassécomposéB, mauvaise: indicatifpassécomposéM)
        indicatifpassésimpleP = "Passé simple: " + pourcentage(bonne: indicatifpassésimpleB, mauvaise: indicatifpassésimpleM)
        indicatifpasséantérieurP = "Passé antérieur: " + pourcentage(bonne: indicatifpasséantérieurB, mauvaise: indicatifpasséantérieurM)
        indicatiffutursimpleP = "Futur simple: " + pourcentage(bonne: indicatiffutursimpleB, mauvaise: indicatiffutursimpleM)
        indicatifplusqueparfaitP = "Plus-que-parfait: " + pourcentage(bonne: indicatifplusqueparfaitB, mauvaise: indicatifplusqueparfaitM)
        indicatiffuturantérieurP = "Futur antérieur: " + pourcentage(bonne: indicatiffuturantérieurB, mauvaise: indicatiffuturantérieurM)
        subjonctifprésentP = "Présent: " + pourcentage(bonne: subjonctifprésentB, mauvaise: subjonctifprésentM)
        subjonctifpasséP = "Passé: " + pourcentage(bonne: subjonctifpasséB, mauvaise: subjonctifpasséM)
        subjonctifimparfaitP = "Imparfait: " + pourcentage(bonne: subjonctifimparfaitB, mauvaise: subjonctifimparfaitM)
        subjonctifplusqueparfaitP = "Plus-que-parfait: " + pourcentage(bonne: subjonctifplusqueparfaitB, mauvaise: subjonctifplusqueparfaitM)
        conditionnelprésentP = "Présent: " + pourcentage(bonne: conditionnelprésentB, mauvaise: conditionnelprésentM)
        conditionnelpasséP = "Passé: " + pourcentage(bonne: conditionnelpasséB, mauvaise: conditionnelpasséM)
        impératifprésentP = "Présent: " + pourcentage(bonne: impératifprésentB, mauvaise: impératifprésentM)
        impératifpasséP = "Passé: " + pourcentage(bonne: impératifpasséB, mauvaise: impératifpasséM)
        
        itemFinal = [[indicatifprésentP, indicatifimparfaitP, indicatifpassécomposéP, indicatiffutursimpleP, indicatifpassésimpleP, indicatifplusqueparfaitP, indicatiffuturantérieurP, indicatifpasséantérieurP], [subjonctifprésentP, subjonctifpasséP, subjonctifimparfaitP, subjonctifplusqueparfaitP, subjonctifplusqueparfaitP], [conditionnelprésentP, conditionnelpasséP], [impératifprésentP, impératifpasséP]]

    }
    
    func pourcentage (bonne: Int, mauvaise: Int) -> String{
        var result = ""
        if (bonne + mauvaise) != 0 {
            result = String(round (Double(bonne) / Double(bonne + mauvaise) * 100)) + "%"
        }else{
            result = "_"
        }
        return result
    }
}
