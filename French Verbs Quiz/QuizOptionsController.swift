//
//  QuizOptionsController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuizOptionsController: UITableViewController {
    var arrayVerbe: [[String]] = []
    var listeVerbes = [String]()
    var arraySelection: [String] = []
    var verbeInfinitif: [String] = []
    var refIndexPath = [IndexPath]()
    var selectedTimeVerbes = NSMutableSet()
    var arr: NSMutableArray = []
    let fontsAndConstraints = FontsAndConstraintsOptions()
    let sectionListe = ["INDICATIF", "SUBJONCTIF", "CONDITIONNEL", "IMPÉRATIF"]
    let item = [["Présent", "Imparfait", "Passé composé", "Futur simple", "Passé simple", "Plus-que-parfait", "Futur antérieur", "Passé antérieur"], ["Présent ", "Passé ", "Imparfait ", "Plus-que-parfait "], ["Présent  ", "Passé  "], ["Présent   ", "Passé   "]]
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor = UIColor(red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        header.textLabel!.textColor = UIColor.white //make the text white
        header.textLabel?.font = fontsAndConstraints.normalBoldFont
        header.alpha = 1.0 //make the header transparent
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        for array in arrayVerbe {
            if listeVerbes.contains(array[2]){
                
            }else{
                listeVerbes.append(array[2])
            }
        }
        self.title = "Choisissez les temps"

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
    


    // Next code is to enable checks for each cell selected
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let helper = Helper()
        cell.textLabel!.text = self.item[indexPath.section][indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font =  fontsAndConstraints.normalItaliqueBoldFont
        configure(cell, forRowAtIndexPath: indexPath)
        return cell
    }
    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if selectedTimeVerbes.contains(indexPath) {
            // selected
            cell.accessoryType = .checkmark
        }
        else {
            // not selected
            cell.accessoryType = .none
        }
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedTimeVerbes.contains(indexPath) {
            // deselect
            selectedTimeVerbes.remove(indexPath)
            let cell2 = tableView.cellForRow(at: indexPath)!
            if let text = cell2.textLabel?.text, let n = arraySelection.index(of: text){
                arraySelection.remove(at: n)
            }
            
        }
        else {
            // select
            selectedTimeVerbes.add(indexPath)
            arraySelection.append(self.item[indexPath.section][indexPath.row])
        }
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
        
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "showQuizController"{
            verbeInfinitif = ["Tous les verbes"]
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let controller = segue.destination as! QuizViewController
            controller.arraySelection = arraySelection
            controller.arrayVerbe = arrayVerbe
            controller.verbeInfinitif = verbeInfinitif
            controller.listeVerbe = listeVerbes
            
        }
        if segue.identifier == "showSpecificVerb"{
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            let controller = segue.destination as! SpecificVerbViewController
            controller.arraySelection = arraySelection
            controller.arrayVerbe = arrayVerbe
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "If faut choisir au moins un temps de verbe.", message: nil, preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = tableView.rectForHeader(inSection: 1)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    func showAlert4 () {
        let alert = UIAlertController(title: "Verbes Français Quiz", message: "Choisissez une option", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Tous les verbes", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.tousLesverbesAction()}))
        alert.addAction(UIAlertAction(title: "Spécifier les Verbes", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.specifierUnVerbe()}))
        self.present(alert, animated: true, completion: nil)
    }
    func tousLesverbesAction() {
        performSegue(withIdentifier: "showQuizController", sender: UIBarButtonItem.self)
    }
    func specifierUnVerbe() {
        performSegue(withIdentifier: "showSpecificVerb", sender: UIBarButtonItem.self)

    }
    
    func dismissAlert(_ sender: UIAlertAction) {
    
    }
    

    @IBAction func OK(_ sender: UIBarButtonItem) {
        var i = 0
        i = arraySelection.count
        if i == 0{
            showAlert()
        }else{
            showAlert4()

        }

    }

}
