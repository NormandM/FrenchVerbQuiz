//
//  SelectVerbsForQuiz.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-07.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
class SelectVerb {
    let arrayVerb: [[String]]
    let tempsEtMode: [[String]]
    let verbInfinitif: [String]
    var verbSelection = [[String]]()
    var verbSelectionRandom = [[String]]()
    init (arrayVerb: [[String]], tempsEtMode: [[String]], verbInfinitif: [String]){
        self.arrayVerb = arrayVerb
        self.tempsEtMode = tempsEtMode
        self.verbInfinitif = verbInfinitif
        for array in arrayVerb {
            let arrayTempsEtMode = [array[1], array[0]]
            for tempMode in tempsEtMode {
                let tempAndMode = [tempMode[0], tempMode[1].lowercased()]
                if verbInfinitif == ["Tous les verbes"] {
                    if tempAndMode == arrayTempsEtMode {
                        if tempMode[1] == "IMPÉRATIF" && (array[2] == "pleuvoir" ||   array[2] == "pouvoir"  || array[2] == "devoir" || array[2] == "falloir" || array[2] == "valoir" || array[2] == "s'extasier" || array[2] == "s'absenter" || array[2] == "neiger" || array[2] == "s'évanouir"){
                            
                        }else{
                            verbSelection.append(array)
                        }
                    }
                }else{
                    for verbInfinitif in verbInfinitif {
                        if tempAndMode == arrayTempsEtMode && verbInfinitif == array[2] {
                            verbSelection.append(array)
                        }
                    }
                }
            }
           
        }
        for verbs in verbSelection {
            if verbs[0] == "impératif"{
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[4], "2"])
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[6], "4"] )
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[7], "5"] )
            }else{
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[3], "1"] )
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[4], "2"])
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[5], "3"] )
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[6], "4"] )
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[7], "5"] )
                verbSelectionRandom.append([verbs[0], verbs[1], verbs[2], verbs[8], "6"] )

            }
        }
        verbSelectionRandom.shuffle()
    }
}
