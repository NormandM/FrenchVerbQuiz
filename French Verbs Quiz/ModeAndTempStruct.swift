//
//  ModeAndTempStruct.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-04.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ModeAndTemp {
    let mode: [String] = ["INDICATIF", "SUBJONCTIF", "CONDITIONNEL", "IMPÉRATIF"]
    let temp: [[String]] = [["Présent", "Imparfait", "Passé composé", "Futur simple", "Passé simple", "Plus-que-parfait", "Futur antérieur", "Passé antérieur"], ["Présent", "Passé", "Imparfait", "Plus-que-parfait"], ["Présent", "Passé"], ["Présent", "Passé"]] 
}
