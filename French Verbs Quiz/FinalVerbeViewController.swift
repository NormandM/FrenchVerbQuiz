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
    
    @IBOutlet weak var infinitif: UILabel!
    @IBOutlet weak var mode: UILabel!
    @IBOutlet weak var temps: UILabel!
    @IBOutlet weak var premier: UILabel!
    @IBOutlet weak var deuxieme: UILabel!
    @IBOutlet weak var troisieme: UILabel!
    @IBOutlet weak var quatrieme: UILabel!
    @IBOutlet weak var cinquieme: UILabel!
    @IBOutlet weak var sixieme: UILabel!
    
    

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
        infinitif.text = verbeFrancais.verbe
        mode.text = verbeFrancais.mode
        temps.text = verbeFrancais.temps
        premier.text = verbeFrancais.premier
        deuxieme.text = verbeFrancais.deuxieme
        troisieme.text = verbeFrancais.troisieme
        quatrieme.text = verbeFrancais.quatrieme
        cinquieme.text = verbeFrancais.cinquieme
        sixieme.text = verbeFrancais.sixieme
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

}
