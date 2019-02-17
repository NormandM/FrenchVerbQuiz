//
//  ChoixDeLaPersonne.swift
//  VerbAppRefactored
//
//  Created by Normand Martin on 2019-02-10.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
struct ChoixDuPronom {
    let mode: String
    let temps: String
    let infinitif: String
    let conjugatedVerb: String
    let personne: String
    let pronom: String
    
    init(mode: String, temps: String, infinitif: String, personne: String, conjugatedVerb: String) {
        self.mode = mode
        self.temps = temps
        self.infinitif = infinitif
        self.personne = personne
        self.conjugatedVerb = conjugatedVerb
        var pronomTrans = String()
        switch personne {
        case "1":
            let firstLetter = conjugatedVerb.first
            if firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "é" || firstLetter == "è" || firstLetter == "h"{
                if mode == "subjonctif"{
                    pronomTrans = "que j'"
                }else {pronomTrans = "j'"}
            }else{
                if mode == "subjonctif"{
                    pronomTrans = "que je"
                }else if mode == "impératif"{
                    pronomTrans = ""
                }else {pronomTrans = "je"}
            }
        case "2":
            if mode == "subjonctif"{
                pronomTrans = "que tu"
            }else if mode == "impératif"{
                pronomTrans = "(tu)"
            }else{
                pronomTrans = "tu"
            }
        case "3":
            if mode == "subjonctif"{
                pronomTrans = "qu'il"
            }else if mode == "impératif"{
                pronomTrans = ""
            }else{
                pronomTrans = "il"
            }
        case "4":
            if mode == "subjonctif"{
                pronomTrans = "que nous"
            }else if mode == "impératif"{
                pronomTrans = "(nous)"
            }else{
                pronomTrans = "nous"
            }
        case "5":
            if mode == "subjonctif"{
                pronomTrans = "que vous"
            }else if mode == "impératif"{
                pronomTrans = "(vous)"
            }else{
                pronomTrans = "vous"
            }
        case "6":
            if mode == "subjonctif"{
                pronomTrans = "qu'ils"
            }else if mode == "impératif"{
                pronomTrans = ""
            }else{
                pronomTrans = "ils"
            }
 
        default:
            break
        }
      pronom = pronomTrans
    }
}
    
    

