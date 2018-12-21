//
//  ResultViewController.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-09.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import UIKit
import Charts

class ResultViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultat: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var termineButton: UIButton!
    @IBOutlet weak var scoreChart: PieChartView!
    var testCompltete = UserDefaults.standard.bool(forKey: "testCompltete")
    var totalProgress: Double = 0
    var goodResponse: Double = 0
    var badResponse = Double()
    var aideCount = Double()
    var wichQuiz = UnwindSegueChoice.toQuizViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCompltete = true
        UserDefaults.standard.set(self.testCompltete, forKey: "testCompltete")
        print(goodResponse)
        print(totalProgress)
        resultat.text = "\(goodResponse + aideCount)/\(totalProgress)"
        let result = Double(goodResponse + aideCount)/Double(totalProgress)
        let resultPercent = String(round(result*100)) + " %"
        
        // Do any additional setup after loading the view.
        if result == 1.0{
            message.text = "Parfait! "
        }else if result < 1 && Double(result) >= 0.75 {
            message.text = "\(resultPercent) Très bien!"
        }else if Double(result) >= 0.6 && Double(result) < 0.75 {
            message.text = "\(resultPercent) Pas Mal!"
        }else if result >= 0 && Double(result) < 0.6 {
            message.text = "\(resultPercent) Essayez à nouveau!"
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        let fonts = FontsAndConstraintsOptions()
        titleLabel.font = fonts.largeBoldFont
        resultat.font = fonts.normalBoldFont
        message.font = fonts.normalItaliqueBoldFont
        termineButton.titleLabel?.font = fonts.normalFont
        termineButton.layer.cornerRadius = termineButton.frame.height/2
        setupChart()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToQuizController" {
            let controller = segue.destination as! QuizViewController
            controller.testCompltete = testCompltete
        }
    }
    func setupChart() {
        scoreChart.chartDescription?.enabled = false
        scoreChart.drawHoleEnabled = false
        scoreChart.rotationAngle = 0
        scoreChart.rotationEnabled = false
        scoreChart.isUserInteractionEnabled = false
        scoreChart.legend.enabled = false
        var entries : [PieChartDataEntry] = Array()
        entries.append(PieChartDataEntry(value: aideCount, label: "Aide"))
        entries.append(PieChartDataEntry(value: goodResponse, label: "Bon"))
        entries.append(PieChartDataEntry(value: badResponse, label: "Mal"))
        let dataSet = PieChartDataSet(values: entries, label: "")
        let cBon = NSUIColor(displayP3Red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
        let cAide = NSUIColor(displayP3Red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
        let cMal = NSUIColor(displayP3Red: 218/255, green: 69/255, blue: 49/255, alpha: 1.0)
        dataSet.colors = [cAide, cBon, cMal]
        dataSet.drawValuesEnabled = false
        scoreChart.data = PieChartData(dataSet: dataSet)
        
    }
   
    // MARK: - Navigation



    @IBAction func termine(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        switch wichQuiz {
        case .toContexteViewController:
            performSegue(withIdentifier: wichQuiz.rawValue, sender: self)
        case .toQuizViewController:
            performSegue(withIdentifier: wichQuiz.rawValue, sender: self)
        }
        
       
    }
}
