//
//  FinalVerbeViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-03.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class FinalVerbeViewController: UIViewController {
    var arrayVerbe: [[String]] = []
    var selectionVerbe = ["", "", ""]
    var noItem: Int = 0
    
    @IBOutlet weak var backgrounColorView: UIView!
    @IBOutlet weak var infinitif: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var premier: UILabel!
    @IBOutlet weak var deuxieme: UILabel!
    @IBOutlet weak var troisieme: UILabel!
    @IBOutlet weak var quatrieme: UILabel!
    @IBOutlet weak var cinquieme: UILabel!
    @IBOutlet weak var sixieme: UILabel!
    @IBOutlet weak var first: UILabel!
    @IBOutlet weak var second: UILabel!
    @IBOutlet weak var third: UILabel!
    @IBOutlet weak var fourth: UILabel!
    @IBOutlet weak var fifth: UILabel!
    @IBOutlet weak var sixth: UILabel!
    let screenSize: CGRect = UIScreen.main.bounds
    let fonts = FontsAndConstraintsOptions()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var n = 0
        for verb in arrayVerbe{
            if verb[0] == selectionVerbe[1].lowercased() && verb[1] == selectionVerbe[2] && verb[2] == selectionVerbe[0]{
                noItem = n
                break
            }
            n = n + 1
        }

        let verbeFrancais = VerbeFrancais(verbArray: arrayVerbe, n: noItem)
      
        let helper = Helper()
        infinitif.text = helper.capitalize(word: verbeFrancais.verbe)
        mode.text = helper.capitalize(word: verbeFrancais.mode)
        temps.text = helper.capitalize(word: verbeFrancais.temps)  
        premier.text = verbeFrancais.premier
        deuxieme.text = verbeFrancais.deuxieme
        troisieme.text = verbeFrancais.troisieme
        quatrieme.text = verbeFrancais.quatrieme
        cinquieme.text = verbeFrancais.cinquieme
        sixieme.text = verbeFrancais.sixieme
        
        let personneVerbe = Personne(verbArray: verbeFrancais)
        if verbeFrancais.verbe == "pleuvoir" || verbeFrancais.verbe == "falloir" || verbeFrancais.verbe == "neiger" {
            first.text = "   "
            second.text = "  "
            third.text = personneVerbe.third
            fourth.text = "  "
            fifth.text = "  "
            sixth.text = "  "
        }else{
            first.text = personneVerbe.first
            second.text = personneVerbe.second
            third.text = personneVerbe.third
            fourth.text = personneVerbe.fourth
            fifth.text = personneVerbe.fifth
            sixth.text = personneVerbe.sixth
            
        }
        infinitif.font = fonts.largeBoldFont
        mode.font = fonts.largeFont
        temps.font = fonts.largeFont
        premier.font = fonts.smallItaliqueBoldFont
        deuxieme.font = fonts.smallItaliqueBoldFont
        troisieme.font = fonts.smallItaliqueBoldFont
        quatrieme.font = fonts.smallItaliqueBoldFont
        cinquieme.font = fonts.smallItaliqueBoldFont
        sixieme.font = fonts.smallItaliqueBoldFont
        first.font = fonts.smallFont
        second.font = fonts.smallFont
        third.font = fonts.smallFont
        fourth.font = fonts.smallFont
        fifth.font = fonts.smallFont
        sixth.font = fonts.smallFont
        
    }

    override func viewWillAppear(_ animated: Bool) {
        self.title = "Verbe conjugué"
        backgrounColorView.layer.cornerRadius = 50
    }
    


}
