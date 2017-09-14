//
//  SpecificVerbViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-02.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import UIKit

class SpecificVerbViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    var randomVerb: Int = 0
    var listeVerbe: [String] = []
    var verbeInfinitif: String = ""
    var nomSection: String = ""
    var leTemps: String = ""
    var verbeTotal = ["", "", ""]
    var verbeChoisiSet = NSMutableSet()
    var verbChoisiArray: [String] = []
    
    var arrayVerbe: [[String]] = []
    var arraySelection: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
   
    
    var searchActive : Bool = false
    var filtered:[String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choisissez le verbe"
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "OK", style: .plain, target: self, action: #selector(showQuiz))
        let i = arrayVerbe.count
        while randomVerb < i {
            let allVerbs = VerbeFrancais(verbArray: arrayVerbe, n: randomVerb)
            listeVerbe.append(allVerbs.verbe)
            randomVerb = randomVerb + 16
        }
        func alpha (_ s1: String, s2: String) -> Bool {
            return s1 < s2
        }
        listeVerbe = listeVerbe.sorted(by: alpha)
        
        
        
        // Do any additional setup after loading the view.
    }
    // Setting up the searchBar active: Ttrue/False
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    //Filtering with search text
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = listeVerbe.filter({ (text) -> Bool in
            let tmp: NSString = text as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return listeVerbe.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell;
        if(searchActive){
            cell.textLabel?.text = filtered[indexPath.row]
            
        } else {
            cell.textLabel?.text = listeVerbe[indexPath.row];
        }
        cell.selectionStyle = .none
        configure(cell, forRowAtIndexPath: indexPath)

        return cell;
    }
  

    func configure(_ cell: UITableViewCell, forRowAtIndexPath indexPath: IndexPath) {
        if verbeChoisiSet.contains(indexPath) {

            // selected
            cell.accessoryType = .checkmark

        }
        else {
            // not selected
            cell.accessoryType = .none
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell2 = tableView.cellForRow(at: indexPath)!
        if verbeChoisiSet.contains(indexPath) {
            // deselect
            verbeChoisiSet.remove(indexPath)
            
            if let text = cell2.textLabel?.text, let n = verbChoisiArray.index(of: text){
                verbChoisiArray.remove(at: n)
            }
            
        }
        else {
            // select
            verbeChoisiSet.add(indexPath)
            verbChoisiArray.append((cell2.textLabel?.text)!)
            //arraySelection.append(listeVerbe[indexPath.row])
        }
        let cell = tableView.cellForRow(at: indexPath)!
        configure(cell, forRowAtIndexPath: indexPath)
        print(verbeChoisiSet)
        print(verbChoisiArray)
    }

    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showQuiz"{
            if let indexPath = self.tableView.indexPathForSelectedRow, let verbeChoisi = tableView.cellForRow(at: indexPath)?.textLabel?.text {
                let backItem = UIBarButtonItem()
                backItem.title = ""
                navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
                let controller = segue.destination as! QuizController
                controller.arrayVerbe = arrayVerbe
                controller.arraySelection = arraySelection
                controller.verbeInfinitif = verbeChoisi
                
            }
        }
    }
    func showQuiz() {
        performSegue(withIdentifier: "showQuiz", sender: Any?.self)
    }
    
    
    
}
