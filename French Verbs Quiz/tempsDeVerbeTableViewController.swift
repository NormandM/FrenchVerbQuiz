//
//  tempsDeVerbeTableViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class tempsDeVerbeTableViewController: UITableViewController {
    var arrayVerbe: [[String]] = []
    var verbeInfinitif: String = ""
    var nomSection: String = ""
    var leTemps: String = ""
    var verbeTotal = ["", "", ""]
    let fontsAndConstraints = FontsAndConstraintsOptions()
    
    let sectionListe = ["INDICATIF", "SUBJONCTIF", "CONDITIONNEL", "IMPÉRATIF"]
    let item = [["Présent", "Imparfait", "Passé composé", "Futur simple", "Passé simple", "Plus-que-parfait", "Futur antérieur", "Passé antérieur"], ["Présent", "Passé", "Imparfait", "Plus-que-parfait"], ["Présent", "Passé"], ["Présent", "Passé"]]
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.alpha = 1.0 //make the header transparent
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choisissez le temps"

     }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionListe[section]
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionListe.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return item[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let helper = Helper()
        cell.textLabel!.text = helper.capitalize(word: self.item[indexPath.section][indexPath.row])
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
        return cell
        
     }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showLeVerbeFinal"{
            if let indexPath = self.tableView.indexPathForSelectedRow {
                leTemps = item[indexPath.section][indexPath.row]
                nomSection = sectionListe[indexPath.section]
                if nomSection == "INDICATIF"{
                    nomSection = "Indicatif"
                }else if nomSection == "SUBJONCTIF"{
                    nomSection = "Subjonctif"
                }else if nomSection == "CONDITIONNEL"{
                    nomSection = "Conditionnel"
                   
                }else if nomSection == "IMPÉRATIF"{
                    nomSection = "Impératif"
                    
                }
                
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem
                
                verbeTotal = [verbeInfinitif, nomSection, leTemps ]
                let controller = segue.destination as! FinalVerbeViewController
                controller.selectionVerbe = verbeTotal
                controller.arrayVerbe = arrayVerbe
            }
            
            
        }
        
    }

}
