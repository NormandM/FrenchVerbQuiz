//
//  ResultViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-09.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var resultat: UILabel!
    @IBOutlet weak var message: UILabel!
    
    
    
    var goodResponse: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        resultat.text = "\(goodResponse)/10"
        // Do any additional setup after loading the view.
        if goodResponse == 10{
            message.text = "Parfait! "
        }else if goodResponse == 9 ||  goodResponse == 8 || goodResponse == 7{
            message.text = "Très bien!"
        }else{
            message.text = "Essayez à nouveau!"
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    @IBAction func termine(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
