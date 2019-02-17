//
//  SpecificVerbViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-02.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import UIKit

class SpecificVerbViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var arraySelectionTempsEtMode = [[String]]()
    var listeVerbeAny: [[Any]] = []
    var arrayFilter: [Any] = []
    var arraySelection: [String] = []
    var arrayVerb = [[String]]()
    var listInfinitif = [String]()
    var searchActive : Bool = false
    var filtered:[String] = []
    var verbesChoisi: [String] = []
    var listeVerbe: [String] = []
    var totalProgress: Double = 0
    lazy var verbList = VerbInfinitif(arrayVerb: arrayVerb)
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        self.title = "Choisir 1 à 10 verbes"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(showQuiz))
        func alpha (_ s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        listInfinitif = verbList.verbList.sorted(by: alpha)
        var n = 0
        for verbe in listInfinitif {
            listeVerbeAny.append([verbe, false, n])
            n = n + 1
        }
    }
    // Setting up the searchBar active: Ttrue/False
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // filter array with string that start with searchText
        self.arrayFilter = listeVerbeAny.filter{
            if let pos = ($0[0] as! String).lowercased().range(of: searchText.lowercased()) {
                return (pos.lowerBound == ($0[0] as! String).startIndex)
            }
            return false
        }
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchBar.text == "" ? self.listeVerbeAny.count : self.arrayFilter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let lista = self.searchBar.text == "" ? self.listeVerbeAny : self.arrayFilter
        let cellAnyArray = lista[indexPath.row] as! [Any]
        cell.textLabel?.textColor = UIColor.black
        let cellText = cellAnyArray[0] as! String
        cell.textLabel?.text = cellText
        // check cell based on second field
        let cellCheck = cellAnyArray[1] as! Bool
        if cellCheck{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        verbesChoisi = []
        var lista = self.searchBar.text == "" ? self.listeVerbeAny : self.arrayFilter
        let idAnyArray = lista[indexPath.row] as! [Any]
        let id = idAnyArray[2] as! Int
        // invert the value of checked
        self.listeVerbeAny[id][1] = !(listeVerbeAny[id][1] as! Bool)
        lista = self.searchBar.text == "" ? self.listeVerbeAny : self.arrayFilter
        
        let cellAnyArray = lista[indexPath.row] as! [Any]
        let cellCheck = cellAnyArray[1] as! Bool
        let cell = tableView.cellForRow(at: indexPath)
        if cellCheck{
            cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
        self.searchBar.text! = ""
        tableView.reloadData()
    }
    func choix() {
        for element in self.listeVerbeAny {
            if element[1] as! Bool {
                verbesChoisi.append(element[0] as! String)
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var okForSegue = true
        for mode in arraySelectionTempsEtMode {
            if mode.contains("impératif"){
                if verbesChoisi.contains("pouvoir") || verbesChoisi.contains("devoir") || verbesChoisi.contains("falloir") || verbesChoisi.contains("pleuvoir") || verbesChoisi.contains("valoir") || (verbesChoisi.contains("s'extasier") && mode[0] == "Passé") || (verbesChoisi.contains("s'absenter") && mode[0] == "Passé") || verbesChoisi.contains("neiger") || (verbesChoisi.contains("s'évanouir") && mode[0] == "Passé"){
                    showAlertPasDImperatif()
                    okForSegue = false
                }
            }
        }
        if okForSegue {
            if segue.identifier == "showQuiz"{
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                let controller = segue.destination as! QuizViewController
                controller.arrayVerb = arrayVerb
                controller.arraySelectionTempsEtMode = arraySelectionTempsEtMode
                controller.verbInfinitif = verbesChoisi
                verbesChoisi = []
            }
        }
    }
    func showAlert () {
        let alertController = UIAlertController(title: "Choisir au moins 1 verbe et au maximum 10 verbes.", message: nil, preferredStyle: .alert)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = tableView.rectForHeader(inSection: 1)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func showAlertPasDImperatif() {
        
        let alertController = UIAlertController(title: "Il n'y a pas d'impératif pour ces verbes:", message: "pouvoir, devoir, falloir, pleuvoir, valoir, neiger, s'extasier(au passé), s'absenter(au passé), s'évanouir(au passé). Faites un autre choix", preferredStyle: .alert)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = tableView.rectForHeader(inSection: 1)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    @objc func showQuiz() {
        choix()
        if verbesChoisi.count == 0 || verbesChoisi.count > 10{
            showAlert()
        }else {
            performSegue(withIdentifier: "showQuiz", sender: Any?.self)
        }
        
    }

}
