//
//  ChoixTempsEtMode.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-15.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit

struct ChoixTempsEtMode {
    static func identificationTempsEtMode (arraySelection: [String]) -> [[String]] {
        var modeChoisi = String()
        var tempsEtMode = [[String]]()
        for arraySelections in arraySelection{
            var n = 0
            var tempsChoisi  = arraySelections
            while tempsChoisi.last == " "{
                tempsChoisi = String(tempsChoisi.dropLast(1))
                n = n + 1
            }
            switch n {
            case 0: modeChoisi = "indicatif"
            case 1: modeChoisi = "subjonctif"
            case 2: modeChoisi = "conditionnel"
            case 3: modeChoisi = "impératif"
            default: modeChoisi = ""
            }
            tempsEtMode.append([tempsChoisi, modeChoisi])
            
        }
        return tempsEtMode
    }
}
