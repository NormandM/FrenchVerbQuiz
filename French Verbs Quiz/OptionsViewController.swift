//
//  OptionsViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-02.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    @IBOutlet weak var listeDesVerbes: UILabel!
    @IBOutlet weak var quizDeBase: UILabel!
    @IBOutlet weak var quizContextuel: UILabel!
    @IBOutlet weak var statistiques: UILabel!
    
    
    var arrayVerbe: [[String]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Choisissez une option"
        if let plistPath = Bundle.main.path(forResource: "frenchVerbsList", ofType: "plist"),
            let verbArray = NSArray(contentsOfFile: plistPath){
            arrayVerbe = verbArray as! [[String]]
        }
        self.navigationItem.setHidesBackButton(true, animated:true)

    }
    override func viewWillAppear(_ animated: Bool) {
        let fonts = FontsAndConstraintsOptions()
        listeDesVerbes.font = fonts.smallItaliqueBoldFont
        quizDeBase.font = fonts.smallItaliqueBoldFont
        quizContextuel.font = fonts.smallItaliqueBoldFont
        statistiques.font = fonts.smallItaliqueBoldFont
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVerbList"{
            let controller = segue.destination as! VerbListViewController
            controller.arrayVerbe = arrayVerbe
        }else if segue.identifier == "showQuizOption"{
            let controller = segue.destination as! QuizOptionsController
            controller.arrayVerbe = arrayVerbe
        }else if segue.identifier == "showContextuelQuizOptionController"{
            let controller = segue.destination as! ContextuelQuizOptionController
            controller.arrayVerbe = arrayVerbe
        }

        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem

    }

    
}
