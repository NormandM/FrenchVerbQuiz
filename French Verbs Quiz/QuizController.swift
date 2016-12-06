//
//  QuizController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class QuizController: UIViewController {
    var arrayVerbe: [[String]] = []
    var arraySelection: [String] = []
    var infinitifVerb: Int = 0
    var listeVerbe: [String] = []
    var verbeChoisi: String = ""
    var tempsChoisi: String = ""
    var modeChoisi: String = ""
    var noPersonne: Int = 0
    var noItem: Int = 0
    var choixPersonne: String = ""
    var reponseBonne: String = ""


    @IBOutlet weak var verbe: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var personne: UILabel!
    @IBOutlet weak var bonneReponse: UILabel!
    
    @IBOutlet weak var reponse: UITextField!
    
    @IBOutlet weak var barreProgression: UIProgressView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectionQuestion()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func selectionQuestion(){
        let i = arrayVerbe.count
        while infinitifVerb < i {
            let allVerbs = VerbeFrancais(verbArray: arrayVerbe, n: infinitifVerb)
            listeVerbe.append(allVerbs.verbe)
            infinitifVerb = infinitifVerb + 16
        }
        let noDeverbe = listeVerbe.count
        let indexVerbeChoisi = Int(arc4random_uniform(UInt32(noDeverbe)))
        verbeChoisi = listeVerbe[indexVerbeChoisi]
        let noTempsChoisi = arraySelection.count
        let indexTempsChoisi = Int(arc4random_uniform(UInt32(noTempsChoisi)))
        tempsChoisi = arraySelection[indexTempsChoisi]
        var n = 0
        while tempsChoisi.characters.last == " "{
            tempsChoisi = String(tempsChoisi.characters.dropLast(1))
            n = n + 1
        }
        if n == 0 {
            modeChoisi = "indicatif"
        }else if n == 1{
            modeChoisi = "subjonctif"
        }else if n == 2{
            modeChoisi = "conditionnel"
        }else if n == 3{
            modeChoisi = "impératif"
        }
        n = 0
        for verb in arrayVerbe {
            if verb[0] == modeChoisi && verb[1] == tempsChoisi && verb[2] == verbeChoisi{
                noItem = n
                break
            }
            n = n + 1
            
        }
        var noPossiblePersonne = 0
        if modeChoisi == "impératif"{
            noPossiblePersonne = 3
        }else{
            noPossiblePersonne = 6
        }
        noPersonne = Int(arc4random_uniform(UInt32(noPossiblePersonne))) + 1
        if modeChoisi == "impératif"{
            if noPersonne == 1 {
                noPersonne = 2
            }else if noPersonne == 2 {
                noPersonne = 4
            }else if noPersonne == 3 {
                noPersonne = 5
            }
        }

        let verbeFrancais = VerbeFrancais(verbArray: arrayVerbe, n: noItem)
        
        verbe.text = verbeFrancais.verbe
        mode.text = verbeFrancais.mode
        temps.text = verbeFrancais.temps
        
        if noPersonne == 1{
            choixPersonne = "premier"
            reponseBonne = verbeFrancais.premier
        }else if noPersonne == 2 {
            choixPersonne = "deuxieme"
            reponseBonne = verbeFrancais.deuxieme
        }else if noPersonne == 3 {
            choixPersonne = "troisieme"
            reponseBonne = verbeFrancais.troisieme
        }else if noPersonne == 4 {
            choixPersonne = "quatrieme"
            reponseBonne = verbeFrancais.quatrieme
        }else if noPersonne == 5 {
            choixPersonne = "cinquieme"
            reponseBonne = verbeFrancais.cinquieme
        }else if noPersonne == 6 {
            choixPersonne = "sixieme"
            reponseBonne = verbeFrancais.sixieme
        }
        bonneReponse.text = reponseBonne
    }
    func evaluationReponse(){
        
    }

    @IBAction func autreQuestion(_ sender: UIBarButtonItem) {
        selectionQuestion()
    }
}
