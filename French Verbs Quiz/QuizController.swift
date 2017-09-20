//
//  QuizController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-04.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import Foundation
import AudioToolbox
import CoreData

class QuizController: UIViewController, NSFetchedResultsControllerDelegate {
    var arrayVerbe: [[String]] = []
    var arraySelection: [String] = []
    var verbeInfinitif: [String] = []
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
    var verbeFinal: String = ""
    var modeFinal: String = ""
    var tempsFinal: String = ""
    var fenetre = UserDefaults.standard.bool(forKey: "fenetre")
    var testCompltete = UserDefaults.standard.bool(forKey: "testCompltete")
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
        testCompltete = false
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

    override func viewDidAppear(_ animated: Bool) {
        if testCompltete == true && fenetre == false {
            showAlert4()
        }
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
        if verbeInfinitif != ["Tous les verbes"] {
            let selection = Selection()
            let choixTempsEtMode = selection.questionSpecifique(arraySelection: arraySelection, arrayVerbe: arrayVerbe, verbeInfinitif: verbeInfinitif)
            verbe.text = choixTempsEtMode[0] as? String
            mode.text = choixTempsEtMode[1] as? String
            temps.text = choixTempsEtMode[2] as? String
            noPersonne = choixTempsEtMode[3] as! Int
            let personneVerbe = choixTempsEtMode[5] as! PersonneTrie
            
            bonneReponse.text = ""
            if verbeFinal == "pleuvoir" || verbeFinal == "falloir" {
                noPersonne = 3
            }
            let question = Question()
            let questionFinale = question.finaleSpecifique(noPersonne: noPersonne, personneVerbe: personneVerbe)
            choixPersonne = questionFinale[0]
            personne.text = questionFinale[1]
            reponseBonne = choixTempsEtMode[4] as! String
        }else{
            let selection = Selection()
            let choixTempsEtMode = selection.questionAleatoire(arraySelection: arraySelection, arrayVerbe: arrayVerbe)
                if verbeFinal == "pleuvoir" || verbeFinal == "falloir" {
                    noPersonne = 3
                }
            verbe.text = choixTempsEtMode[0] as? String
            mode.text = choixTempsEtMode[1] as? String
            temps.text = choixTempsEtMode[2] as? String
            bonneReponse.text = ""
            choixPersonne = choixTempsEtMode[3] as! String
            personne.text = choixTempsEtMode[4] as? String
            reponseBonne = choixTempsEtMode[5] as! String
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
            let when = DispatchTime.now() + 1.5 // change 2 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.performSegue(withIdentifier: "showResult", sender: nil)
            }
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
        alertController.popoverPresentationController?.sourceRect = temps.frame
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: dismissAlert)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
   }
    func dismissAlert(_ sender: UIAlertAction) {
        
    }
    func showAlert4 () {
        
        let alert = UIAlertController(title: "Verbes Français Quiz", message: "Votre opinion est importante pour améliorer l’application. Vos commentaires seraient appréciés.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "D'accord ", style: UIAlertActionStyle.default, handler:{(alert: UIAlertAction!) in self.rateApp(appId: "id1189770403") { success in
            print("RateApp \(success)")
            }}))
        alert.addAction(UIAlertAction(title: "Pas maintenant", style: UIAlertActionStyle.default, handler: nil))
        //self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ne plus me montrer cette fenêtre", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in self.fenetre = true; UserDefaults.standard.set(self.fenetre, forKey: "fenetre") }))
        self.present(alert, animated: true, completion: nil)
    }
    func rateApp(appId: String, completion: @escaping ((_ success: Bool)->())) {
        guard let url = URL(string : "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: completion)
    }
}
