//
//  PieChartSetUp.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-12-26.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
import Charts

struct PieChartSetUp {
    let entrieBon: Double
    let entrieMal: Double
    let entrieAide: Double
    let pieChartView: PieChartView
    let cBon = NSUIColor(displayP3Red: 27/255, green: 95/255, blue: 94/255, alpha: 1.0)
    let cMal = NSUIColor(displayP3Red: 218/255, green: 69/255, blue: 49/255, alpha: 1.0)
    let cAide = NSUIColor(displayP3Red: 178/255, green: 208/255, blue: 198/255, alpha: 1.0)
    var piechartData: ChartData
    init(entrieBon: Double, entrieMal: Double, entrieAide: Double, pieChartView: PieChartView){
        self.entrieBon = entrieBon
        self.entrieMal = entrieMal
        self.entrieAide = entrieAide
        self.pieChartView = pieChartView
        var pieDataLocal = ChartData()
        pieChartView.chartDescription?.enabled = false
        pieChartView.drawHoleEnabled = false
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = false
        pieChartView.isUserInteractionEnabled = false
        pieChartView.legend.enabled = false
        var entries : [PieChartDataEntry] = Array()
        let casesPie = [entrieBon,entrieMal,entrieAide]
        switch casesPie {
        case [entrieBon,0,0]:
            entries.append(PieChartDataEntry(value: entrieBon, label: "Bon"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cBon]
            pieDataLocal = PieChartData(dataSet: dataSet)
            
        case [0,entrieMal,0]:
            entries.append(PieChartDataEntry(value: entrieMal, label: "Mal"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cMal]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        case [0,0,entrieAide]:
            entries.append(PieChartDataEntry(value: entrieAide, label: "Aide"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cAide]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        case [entrieBon,entrieMal,0]:
            entries.append(PieChartDataEntry(value: entrieBon, label: "Bon"))
            entries.append(PieChartDataEntry(value: entrieMal, label: "Mal"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cBon, cMal]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        case [entrieBon,0,entrieAide]:
            entries.append(PieChartDataEntry(value: entrieBon, label: "Bon"))
            entries.append(PieChartDataEntry(value: entrieAide, label: "Aide"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cBon, cAide]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        case[0,entrieMal,entrieAide]:
            entries.append(PieChartDataEntry(value: entrieMal, label: "Mal"))
            entries.append(PieChartDataEntry(value: entrieAide, label: "Aide"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cMal, cAide]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        case [entrieBon,entrieMal,entrieAide]:
            entries.append(PieChartDataEntry(value: entrieAide, label: "Aide"))
            entries.append(PieChartDataEntry(value: entrieBon, label: "Bon"))
            entries.append(PieChartDataEntry(value: entrieMal, label: "Mal"))
            let dataSet = PieChartDataSet(values: entries, label: "")
            dataSet.colors = [cAide, cBon, cMal]
            pieDataLocal = PieChartData(dataSet: dataSet)
            dataSet.drawValuesEnabled = false
        default:
            break
        }
        piechartData = pieDataLocal
    }
}
