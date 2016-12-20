//
//  QuizController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreData

class QuizController: UIViewController, NSFetchedResultsControllerDelegate {
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
    var progress: Float = 0.0
    var progressInt: Float = 0.0
    var goodResponse: Int = 0
    var soundURL: NSURL?
    var soundID:SystemSoundID = 0
    var didSave: Bool = false
    var contexte: String = ""
    var explication: String = ""
    var verbeFinal: String = ""
    var modeFinal: String = ""
    var tempsFinal: String = ""

    let dataController = DataController.sharedInstance
    let managedObjectContext = DataController.sharedInstance.managedObjectContext
    lazy var fetchRequest: NSFetchRequest<NSFetchRequestResult> = {
        let request  = NSFetchRequest<NSFetchRequestResult>(entityName: ItemVerbe.identifier)
        let sortDescriptor = NSSortDescriptor(key: "verbeInfinitif", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        return request
    }()
    
    var items: [ItemVerbe] = []
    @IBOutlet weak var verbe: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var personne: UILabel!
    @IBOutlet weak var bonneReponse: UILabel!
    @IBOutlet weak var reponse: UITextField!
    @IBOutlet weak var barreProgression: UIProgressView!
    @IBOutlet weak var checkButton: UIButton!
    
    let screenSize: CGRect = UIScreen.main.bounds
    @IBOutlet weak var masterConstraint: NSLayoutConstraint!
    @IBOutlet weak var tempsConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        masterConstraint.constant = 0.10 * screenSize.height
        tempsConstraint.constant = 0.10 * screenSize.height
        
        self.title = "Répondez à la question."
        barreProgression.progress = 0.0
        selectionQuestion()
        do {
            items = try managedObjectContext.fetch(fetchRequest) as! [ItemVerbe]
        }catch let error as NSError {
            print("Error fetching Item objects: \(error.localizedDescription), \(error.userInfo)")
        }
    }
    // the 3 next function moves the KeyBoards when keyboard appears or hides
 
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if UIDevice.current.userInterfaceIdiom == .pad && (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            animateViewMoving(true, moveValue: 50)
            }
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            if UIDevice.current.userInterfaceIdiom == .pad && (UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight){
            animateViewMoving(false, moveValue: 50)
            }
        }
        func animateViewMoving (_ up:Bool, moveValue :CGFloat){
            let movementDuration:TimeInterval = 0.3
            let movement:CGFloat = ( up ? -moveValue : moveValue)
            UIView.beginAnimations( "animateView", context: nil)
            UIView.setAnimationBeginsFromCurrentState(true)
            UIView.setAnimationDuration(movementDuration )
            self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
            UIView.commitAnimations()
        }


    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: NAVIGATION
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let controller = segue.destination as! ResultViewController
            controller.goodResponse = goodResponse
        }
    }
    
 //////////////////////////////////////
// MARK: ALL BUTTON AND ACTIONS
//////////////////////////////////////
    @IBAction func autreQuestion(_ sender: UIBarButtonItem) {
        selectionQuestion()
        bonneReponse.text = ""
        reponse.text = ""
        checkButton.isEnabled = true
        reponse.isEnabled = true
    }

    @IBAction func check(_ sender: UIButton) {
        evaluationReponse()
        reponse.resignFirstResponder()
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        reponse.isEnabled = false

    }
    
    
    @IBAction func unwindToLast(segue: UIStoryboardSegue) {
        progressInt = 0.0
        progress = 0.0
        goodResponse = 0
        barreProgression.progress = 0.0
        bonneReponse.text = ""
        reponse.text = ""
        checkButton.isEnabled = true
        reponse.isEnabled = true
        selectionQuestion()
        
    }
    @IBAction func exemple(_ sender: Any) {
        showAlert()
    }

    
/////////////////////////////////////
// MARK: ALL FUNCTIONS
/////////////////////////////////////
    func selectionQuestion(){
        // Selecting verb tense
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
        
        //Selecting verb for question
        let i = arrayVerbe.count
        while infinitifVerb < i {
            let allVerbs = VerbeFrancais(verbArray: arrayVerbe, n: infinitifVerb)
            if modeChoisi == "impératif" && (allVerbs.verbe == "pouvoir" || allVerbs.verbe == "vouloir" || allVerbs.verbe == "devoir" || allVerbs.verbe == "falloir" || allVerbs.verbe == "pleuvoir" || allVerbs.verbe == "valoir") {
                // not appending
            }else{
                listeVerbe.append(allVerbs.verbe)
            }
            infinitifVerb = infinitifVerb + 16
        }
        let noDeverbe = listeVerbe.count
        let indexVerbeChoisi = Int(arc4random_uniform(UInt32(noDeverbe)))
        verbeChoisi = listeVerbe[indexVerbeChoisi]
        n = 0
        
        //Selecting person for question
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
        let personneVerbe = Personne(verbArray: verbeFrancais)
        verbeFinal = verbeFrancais.verbe
        modeFinal = verbeFrancais.mode
        tempsFinal = verbeFrancais.temps
        let helper = Helper()
        verbe.text = helper.capitalize(word: verbeFinal)
        mode.text = helper.capitalize(word: modeFinal)
        temps.text = helper.capitalize(word: tempsFinal)
    
        bonneReponse.text = ""
        if verbeFinal == "pleuvoir" || verbeFinal == "falloir" {
            noPersonne = 3
        }
        if noPersonne == 1{
            choixPersonne = "premier"
            reponseBonne = verbeFrancais.premier
            personne.text = personneVerbe.first
        }else if noPersonne == 2 {
            choixPersonne = "deuxieme"
            reponseBonne = verbeFrancais.deuxieme
            personne.text = personneVerbe.second
        }else if noPersonne == 3 {
            choixPersonne = "troisieme"
            reponseBonne = verbeFrancais.troisieme
            personne.text = personneVerbe.third
        }else if noPersonne == 4 {
            choixPersonne = "quatrieme"
            reponseBonne = verbeFrancais.quatrieme
            personne.text = personneVerbe.fourth
        }else if noPersonne == 5 {
            choixPersonne = "cinquieme"
            reponseBonne = verbeFrancais.cinquieme
            personne.text = personneVerbe.fifth
        }else if noPersonne == 6 {
            choixPersonne = "sixieme"
            reponseBonne = verbeFrancais.sixieme
            personne.text = personneVerbe.sixth
        }
        
    }

    func evaluationReponse(){
        if reponse.text == reponseBonne{
            goodResponse = goodResponse + 1
            bonneReponse.text = "Bravo!"
            let filePath = Bundle.main.path(forResource: "Incoming Text 01", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)
            bonneReponse.textColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
            didSave = false
            for item in items {
                if item.tempsVerbe == temps.text && item.modeVerbe == mode.text && item.verbeInfinitif == verbe.text{
                    item.bonneReponse = item.bonneReponse + 1
                    didSave = true
                }
            }
            if didSave == false {
                let itemVerbe = NSEntityDescription.insertNewObject(forEntityName: "ItemVerbe", into: dataController.managedObjectContext) as! ItemVerbe
                itemVerbe.verbeInfinitif = verbeFinal
                itemVerbe.tempsVerbe = tempsFinal
                itemVerbe.modeVerbe = modeFinal
                itemVerbe.bonneReponse = itemVerbe.bonneReponse + 1
            }
            dataController.saveContext()
            
        }else{
            didSave = false
            for item in items {
                if item.tempsVerbe == temps.text && item.modeVerbe == mode.text && item.verbeInfinitif == verbe.text{
                    item.mauvaiseReponse = item.mauvaiseReponse + 1
                    didSave = true
                }
                
                
            }
            if didSave == false {
                let itemVerbe = NSEntityDescription.insertNewObject(forEntityName: "ItemVerbe", into: dataController.managedObjectContext) as! ItemVerbe
                itemVerbe.verbeInfinitif = verbeFinal
                itemVerbe.tempsVerbe = tempsFinal
                itemVerbe.modeVerbe = modeFinal
                itemVerbe.mauvaiseReponse = itemVerbe.mauvaiseReponse + 1
                
            }
            
            dataController.saveContext()
            bonneReponse.text = reponseBonne
            bonneReponse.textColor = UIColor(red: 255/255, green: 17/255, blue: 93/255, alpha: 1.0)
            let filePath = Bundle.main.path(forResource: "Error Warning", ofType: "wav")
            soundURL = NSURL(fileURLWithPath: filePath!)
            AudioServicesCreateSystemSoundID(soundURL!, &soundID)
            AudioServicesPlaySystemSound(soundID)
            
        }
        
        progressClaculation()
        if progressInt == 10.0 {
            performSegue(withIdentifier: "showResult", sender: nil)
        }
    }
    func textFieldShouldReturn(_ reponse: UITextField) -> Bool {
        evaluationReponse()
        reponse.resignFirstResponder()
        checkButton.isEnabled = false
        checkButton.setTitleColor(UIColor.gray, for: .disabled)
        reponse.isEnabled = false
        
        return true
        
    }
    func progressClaculation() {
        progressInt = progressInt + 1
        progress = progressInt / 10
        barreProgression.progress = progress
    }
    func showAlert () {
        let verbeFrancais = VerbeFrancais(verbArray: arrayVerbe, n: noItem)
        let contexteVerbe = ContexteVerbe(verbArray: verbeFrancais)
        let alertController = UIAlertController(title: contexteVerbe.contexte[0], message: contexteVerbe.contexte[1], preferredStyle: .actionSheet)
        alertController.popoverPresentationController?.sourceView = self.view
        alertController.popoverPresentationController?.sourceRect = verbe.frame
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
   }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }


}
