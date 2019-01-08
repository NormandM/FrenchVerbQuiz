//
//  StatistiqueTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-11.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import CoreData
import Charts

class StatistiqueTableViewController: UITableViewController {
   
    
    
    @IBOutlet weak var remiseAZeroButton: UIButton!
    
    
    var itemFinal: [[String]] = []
    var itemForPieChartNumBers = [[(Int, Int, Int)]]()
    let dataController = DataController.sharedInstance
    let fonts = FontsAndConstraintsOptions()
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
        header.contentView.backgroundColor =  UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.textLabel?.font = fonts.largeBoldFont
        header.alpha = 1.0 //make the header transparent
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateData()
 
     }
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Statistiques du Quiz"
        remiseAZeroButton.layer.cornerRadius = remiseAZeroButton.frame.height / 2.0
        remiseAZeroButton.titleLabel?.font = fonts.normalBoldFont
    }


    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionListe[section]
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return view.frame.height * 0.05
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionListe.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemInitial[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StatistiqueViewCell
        cell.labelForCell.font = fonts.normalItaliqueBoldFont
        cell.labelForCell.textAlignment = .center
        cell.labelForCell.numberOfLines = 0
        cell.labelForCell.text = self.itemFinal[indexPath.section][indexPath.row]
        let entrieBon = Double(itemForPieChartNumBers[indexPath.section][indexPath.row].0)
        let entrieMal = Double(itemForPieChartNumBers[indexPath.section][indexPath.row].1)
        let entrieAide = Double(itemForPieChartNumBers[indexPath.section][indexPath.row].2)
        let pieChartSetUp = PieChartSetUp(entrieBon: entrieBon, entrieMal: entrieMal, entrieAide: entrieAide, pieChartView: cell.viewForCell )
        cell.viewForCell.data = pieChartSetUp.piechartData
        return cell
    }
//////////////////////////////////////
// MARK: All Buttons and actions
//////////////////////////////////////

     @IBAction func remettreAZero(_ sender: UIButton) {
        remiseAZeroButton.tintColor = UIColor.black
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
        var indicatifprésentA: Int = 0
        var indicatifprésentM: Int = 0
        var indicatifimparfaitB: Int = 0
         var indicatifimparfaitA: Int = 0
        var indicatifimparfaitM: Int = 0
        var indicatifpassécomposéB: Int = 0
         var indicatifpassécomposéA: Int = 0
        var indicatifpassécomposéM: Int = 0
        var indicatifpassésimpleB: Int = 0
        var indicatifpassésimpleA: Int = 0
        var indicatifpassésimpleM: Int = 0
        var indicatifpasséantérieurB: Int = 0
        var indicatifpasséantérieurA: Int = 0
        var indicatifpasséantérieurM: Int = 0
        var indicatiffutursimpleB: Int = 0
        var indicatiffutursimpleA: Int = 0
        var indicatiffutursimpleM: Int = 0
        var indicatifplusqueparfaitB: Int = 0
        var indicatifplusqueparfaitA: Int = 0
        var indicatifplusqueparfaitM: Int = 0
        var indicatiffuturantérieurB: Int = 0
        var indicatiffuturantérieurA: Int = 0
        var indicatiffuturantérieurM: Int = 0
        var subjonctifprésentB: Int = 0
        var subjonctifprésentA: Int = 0
        var subjonctifprésentM: Int = 0
        var subjonctifpasséB: Int = 0
        var subjonctifpasséA: Int = 0
        var subjonctifpasséM: Int = 0
        var subjonctifimparfaitB: Int = 0
        var subjonctifimparfaitA: Int = 0
        var subjonctifimparfaitM: Int = 0
        var subjonctifplusqueparfaitB: Int = 0
        var subjonctifplusqueparfaitA: Int = 0
        var subjonctifplusqueparfaitM: Int = 0
        var conditionnelprésentB: Int = 0
        var conditionnelprésentA: Int = 0
        var conditionnelprésentM: Int = 0
        var conditionnelpasséB: Int = 0
        var conditionnelpasséA: Int = 0
        var conditionnelpasséM: Int = 0
        var impératifprésentB: Int = 0
        var impératifprésentA: Int = 0
        var impératifprésentM: Int = 0
        var impératifpasséB: Int = 0
        var impératifpasséA: Int = 0
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
                    indicatifprésentA = indicatifprésentA + Int(item.bonneReponseTemps)
                case .conditionnelPassé:
                    conditionnelpasséB = conditionnelpasséB + Int(item.bonneReponse)
                    conditionnelpasséM = conditionnelpasséM + Int(item.mauvaiseReponse)
                    conditionnelpasséA = conditionnelpasséA + Int(item.bonneReponseTemps)
                case .conditionnelPrésent:
                    conditionnelprésentB = conditionnelprésentB + Int(item.bonneReponse)
                    conditionnelprésentM = conditionnelprésentM + Int(item.mauvaiseReponse)
                    conditionnelprésentA = conditionnelprésentA + Int(item.bonneReponseTemps)
                case .futurAntérieur:
                    indicatiffuturantérieurB = indicatiffuturantérieurB + Int(item.bonneReponse)
                    indicatiffuturantérieurM = indicatiffuturantérieurM + Int(item.mauvaiseReponse)
                    indicatiffuturantérieurA = indicatiffuturantérieurA + Int(item.bonneReponseTemps)
                case .futurSimple:
                    indicatiffutursimpleB = indicatiffutursimpleB + Int(item.bonneReponse)
                    indicatiffutursimpleM = indicatiffutursimpleM + Int(item.mauvaiseReponse)
                    indicatiffutursimpleA = indicatiffutursimpleA + Int(item.bonneReponseTemps)
                case .imparfait:
                    indicatifimparfaitB = indicatifimparfaitB + Int(item.bonneReponse)
                    indicatifimparfaitM = indicatifimparfaitM + Int(item.mauvaiseReponse)
                    indicatifimparfaitA = indicatifimparfaitA + Int(item.bonneReponseTemps)
                case .impératifPassé:
                    impératifpasséB = impératifpasséB + Int(item.bonneReponse)
                    impératifpasséM = impératifpasséM + Int(item.mauvaiseReponse)
                    impératifpasséA = impératifpasséA + Int(item.bonneReponseTemps)
                case .impératifPrésent:
                    impératifprésentB = impératifprésentB + Int(item.bonneReponse)
                    impératifprésentM = impératifprésentM + Int(item.mauvaiseReponse)
                    impératifprésentA = impératifprésentA + Int(item.bonneReponseTemps)
                case .passé:
                    indicatifpassécomposéB = indicatifpassécomposéB + Int(item.bonneReponse)
                    indicatifpassécomposéM = indicatifpassécomposéM + Int(item.mauvaiseReponse)
                    indicatifpassécomposéA = indicatifpassécomposéA + Int(item.bonneReponseTemps)
                case .passéAntérieur:
                    indicatifpasséantérieurB = indicatifpasséantérieurB + Int(item.bonneReponse)
                    indicatifpasséantérieurM = indicatifpasséantérieurM + Int(item.mauvaiseReponse)
                    indicatifpasséantérieurA = indicatifpasséantérieurA + Int(item.bonneReponseTemps)
                case .passéSimple:
                    indicatifpassésimpleB = indicatifpassésimpleB + Int(item.bonneReponse)
                    indicatifpassésimpleM = indicatifpassésimpleM + Int(item.mauvaiseReponse)
                    indicatifpassésimpleA = indicatifpassésimpleA + Int(item.bonneReponseTemps)
                case .plusQueParfait:
                    indicatifplusqueparfaitB = indicatifplusqueparfaitB + Int(item.bonneReponse)
                    indicatifplusqueparfaitM = indicatifplusqueparfaitM + Int(item.mauvaiseReponse)
                    indicatifplusqueparfaitA = indicatifplusqueparfaitA + Int(item.bonneReponseTemps)
                case .subjonctifImparfait:
                    subjonctifimparfaitB = subjonctifimparfaitB + Int(item.bonneReponse)
                    subjonctifimparfaitM = subjonctifimparfaitM + Int(item.mauvaiseReponse)
                    subjonctifimparfaitA = subjonctifimparfaitA + Int(item.bonneReponseTemps)
                case .subjonctifPassé:
                    subjonctifpasséB = subjonctifpasséB + Int(item.bonneReponse)
                    subjonctifpasséM = subjonctifpasséM + Int(item.mauvaiseReponse)
                    subjonctifpasséA = subjonctifpasséA + Int(item.bonneReponseTemps)
                case .subjonctifPlusQueParfait:
                    subjonctifplusqueparfaitB = subjonctifplusqueparfaitB + Int(item.bonneReponse)
                    subjonctifplusqueparfaitM = subjonctifplusqueparfaitM + Int(item.mauvaiseReponse)
                    subjonctifplusqueparfaitA = subjonctifplusqueparfaitA + Int(item.bonneReponseTemps)
                case .subjonctifPrésent:
                    subjonctifprésentB = subjonctifprésentB + Int(item.bonneReponse)
                    subjonctifprésentM = subjonctifprésentM + Int(item.mauvaiseReponse)
                    subjonctifprésentA = subjonctifprésentA + Int(item.bonneReponseTemps)
                }
            }
            
        }
        indicatifprésentP = """
        Présent:
        \(pourcentage(bonne: indicatifprésentB, mauvaise: indicatifprésentM, aide: indicatifprésentA))
        """
        indicatifimparfaitP = """
        Imparfait:
        \(pourcentage(bonne: indicatifimparfaitB, mauvaise: indicatifimparfaitM, aide: indicatifimparfaitA))
        """
        indicatifpassécomposéP = """
        Passé composé:
        \(pourcentage(bonne: indicatifpassécomposéB, mauvaise: indicatifpassécomposéM, aide: indicatifpassécomposéA))
        """
        indicatifpassésimpleP = """
        Passé simple:
        \(pourcentage(bonne: indicatifpassésimpleB, mauvaise: indicatifpassésimpleM, aide: indicatifpassésimpleA))
        """
        indicatifpasséantérieurP = """
        Passé antérieur:
        \(pourcentage(bonne: indicatifpasséantérieurB, mauvaise: indicatifpasséantérieurM, aide: indicatifpasséantérieurA))
        """
        indicatiffutursimpleP = """
        Futur simple:
        \(pourcentage(bonne: indicatiffutursimpleB, mauvaise: indicatiffutursimpleM, aide: indicatiffutursimpleA))
        """
        indicatifplusqueparfaitP = """
        Plus-que-parfait:
        \(pourcentage(bonne: indicatifplusqueparfaitB, mauvaise: indicatifplusqueparfaitM, aide: indicatifplusqueparfaitA))
        """
        indicatiffuturantérieurP = """
        Futur antérieur:
        \(pourcentage(bonne: indicatiffuturantérieurB, mauvaise: indicatiffuturantérieurM, aide: indicatiffuturantérieurA))
        """
        subjonctifprésentP = """
        Présent:
        \(pourcentage(bonne: subjonctifprésentB, mauvaise: subjonctifprésentM, aide: subjonctifprésentA))
        """
        subjonctifpasséP = """
        Passé:
        \(pourcentage(bonne: subjonctifpasséB, mauvaise: subjonctifpasséM, aide: subjonctifpasséA))
        """
        subjonctifimparfaitP = """
        Imparfait:
        \(pourcentage(bonne: subjonctifimparfaitB, mauvaise: subjonctifimparfaitM, aide: subjonctifimparfaitA))
        """
        subjonctifplusqueparfaitP = """
        Plus-que-parfait:
        \(pourcentage(bonne: subjonctifplusqueparfaitB, mauvaise: subjonctifplusqueparfaitM, aide: subjonctifplusqueparfaitA))
        """
        conditionnelprésentP = """
        Présent:
        \(pourcentage(bonne: conditionnelprésentB, mauvaise: conditionnelprésentM, aide: conditionnelprésentA))
        """
        conditionnelpasséP = """
        Passé:
        \(pourcentage(bonne: conditionnelpasséB, mauvaise: conditionnelpasséM, aide: conditionnelpasséA))
        """
        impératifprésentP = """
        Présent:
        \(pourcentage(bonne: impératifprésentB, mauvaise: impératifprésentM, aide: impératifprésentA))
        """
        impératifpasséP = """
        Passé:
        \(pourcentage(bonne: impératifpasséB, mauvaise: impératifpasséM, aide: impératifpasséA))
        """
        itemFinal = [[indicatifprésentP, indicatifimparfaitP, indicatifpassécomposéP, indicatiffutursimpleP, indicatifpassésimpleP, indicatifplusqueparfaitP, indicatiffuturantérieurP, indicatifpasséantérieurP], [subjonctifprésentP, subjonctifpasséP, subjonctifimparfaitP, subjonctifplusqueparfaitP, subjonctifplusqueparfaitP], [conditionnelprésentP, conditionnelpasséP], [impératifprésentP, impératifpasséP]]
        itemForPieChartNumBers = [[(indicatifprésentB, indicatifprésentM, indicatifprésentA), (indicatifimparfaitB, indicatifimparfaitM,indicatifimparfaitA), (indicatifpassécomposéB, indicatifpassécomposéM, indicatifpassécomposéA), (indicatiffutursimpleB, indicatiffutursimpleM, indicatiffutursimpleA),(indicatifpassésimpleB, indicatifpassésimpleM, indicatifpassésimpleA), (bonne: indicatifplusqueparfaitB, mauvaise: indicatifplusqueparfaitM, aide: indicatifplusqueparfaitA), (bonne: indicatiffuturantérieurB, mauvaise: indicatiffuturantérieurM, aide: indicatiffuturantérieurA), (indicatifpasséantérieurB, indicatifpasséantérieurM, indicatifpasséantérieurA)],  [(subjonctifprésentB, subjonctifprésentM, subjonctifprésentA), (subjonctifpasséB, mauvaise: subjonctifpasséM, aide: subjonctifpasséA), (subjonctifimparfaitB, subjonctifimparfaitM, subjonctifimparfaitA), (subjonctifplusqueparfaitB, subjonctifplusqueparfaitM, subjonctifplusqueparfaitA)], [(conditionnelprésentB, conditionnelprésentM, conditionnelprésentA), (conditionnelpasséB, conditionnelpasséM, conditionnelpasséA)], [(impératifprésentB, impératifprésentM, impératifprésentA), (impératifpasséB, impératifpasséM, impératifpasséA)]]

    }
    
    func pourcentage (bonne: Int, mauvaise: Int, aide: Int) -> String{
        var result = ""
        if (bonne + mauvaise + aide) != 0 {
            result = String(round (Double(bonne + aide) / Double(bonne + mauvaise + aide) * 100)) + "%"
        }else{
            result = "_"
        }
        return result
    }

}
