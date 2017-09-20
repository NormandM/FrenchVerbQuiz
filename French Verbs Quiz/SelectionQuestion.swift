//
//  SelectionQuestion.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 17-09-19.
//  Copyright © 2017 Normand Martin. All rights reserved.
//

import Foundation
class Selection {
    var noDeverbe = 0
    var indexDesVerbes: [Int] = []
    var indexChoisi: Int = 0
    var infinitifVerb: Int = 0
    var listeVerbe: [String] = []
    var verbeChoisi: String = ""
    var tempsChoisi: String = ""
    var modeChoisi: String = ""
    var noPersonne: Int = 0
    var noItem: Int = 0
    var choixPersonne: String = ""
    var reponseBonne: String = ""
    var verbeFinal: String = ""
    var modeFinal: String = ""
    var tempsFinal: String = ""
    var tempsEtMode: [[String]] = []

// verbes spécifiés
    func questionSpecifique(arraySelection: [String], arrayVerbe: [[String]], verbeInfinitif: [String]) -> [Any]{
        // Selecting verb tense
        var tempsEtModeChoisi: [Any] = []
        tempsEtMode = choixTempsEtMode(arraySelection: arraySelection)
        listeVerbe = verbeInfinitif
        var allInfoList: [[String]] = []
        for arrayVerbes in arrayVerbe {
            if listeVerbe.contains(arrayVerbes[2]){
                for tempsEtModes in tempsEtMode {
                    if tempsEtModes.contains(arrayVerbes[0]) && tempsEtModes.contains(arrayVerbes[1]){
                        if arrayVerbes[3] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[3], "1"])}
                        if arrayVerbes[4] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[4], "2"])}
                        if arrayVerbes[5] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[5], "3"])}
                        if arrayVerbes[6] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[6], "4"])}
                        if arrayVerbes[7] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[7], "5"])}
                        if arrayVerbes[8] != "" {allInfoList.append([arrayVerbes[0], arrayVerbes[1], arrayVerbes[2], arrayVerbes[8], "6"])}
                    }
                }
            }
        }
        print(allInfoList)
        if indexChoisi == 0 {
            let randomNumber = RandomNumber()
            noDeverbe = allInfoList.count
            indexDesVerbes = randomNumber.generate(from: 0, to: noDeverbe - 1, quantity: nil)
        }
        print(indexDesVerbes)
        let verbeTrie = VerbeTrie(allInfoList: allInfoList, n: indexDesVerbes[indexChoisi])
        let personneVerbe = PersonneTrie(verbeTrie: verbeTrie)

        verbeFinal = verbeTrie.verbe
        modeFinal = verbeTrie.mode
        tempsFinal = verbeTrie.temps
        noPersonne = Int(verbeTrie.personne)!
        let helper = Helper()
        tempsEtModeChoisi = [helper.capitalize(word: verbeFinal), helper.capitalize(word: modeFinal), helper.capitalize(word: tempsFinal), noPersonne, verbeTrie.verbeConjugue, personneVerbe]
        if indexChoisi == indexDesVerbes.count{
            print("text Terminé")
        }
        indexChoisi = indexChoisi + 1
        return tempsEtModeChoisi
    }
    
    
/////////Tous les verbes
    func questionAleatoire(arraySelection: [String], arrayVerbe: [[String]]) -> [Any]{
            listeVerbe = []
            infinitifVerb = 0
            var tempsEtModeChoisi: [Any] = []
            tempsEtMode = choixTempsEtMode(arraySelection: arraySelection)
            let noTempsChoisi = tempsEtMode.count
            let indexTempsChoisi = Int(arc4random_uniform(UInt32(noTempsChoisi)))
            tempsChoisi = tempsEtMode[indexTempsChoisi][0]
            modeChoisi = tempsEtMode[indexTempsChoisi][1]
            
            let i = arrayVerbe.count
            print("i = \(i)")
            while infinitifVerb < i {
                let allVerbs = VerbeFrancais(verbArray: arrayVerbe, n: infinitifVerb)
                if modeChoisi == "impératif" && (allVerbs.verbe == "pouvoir" || allVerbs.verbe == "vouloir" || allVerbs.verbe == "devoir" || allVerbs.verbe == "falloir" || allVerbs.verbe == "pleuvoir" || allVerbs.verbe == "valoir") {
                    // not appending
                }else{
                    listeVerbe.append(allVerbs.verbe)
                }
                infinitifVerb = infinitifVerb + 16
            }
            let noDeverbe = listeVerbe.count
            let indexVerbeChoisi = Int(arc4random_uniform(UInt32(noDeverbe)))
            verbeChoisi = listeVerbe[indexVerbeChoisi]
            print(verbeChoisi)
            var n = 0
            
            //Selecting person for question
            for verb in arrayVerbe {
                if verb[0] == modeChoisi && verb[1] == tempsChoisi && verb[2] == verbeChoisi{
                    noItem = n
                    break
                }
                n = n + 1
            }
            var noPossiblePersonne = 0
            if modeChoisi == "impératif"{
                noPossiblePersonne = 3
            }else{
                noPossiblePersonne = 6
            }
            noPersonne = Int(arc4random_uniform(UInt32(noPossiblePersonne))) + 1
            if modeChoisi == "impératif"{
                if noPersonne == 1 {
                    noPersonne = 2
                }else if noPersonne == 2 {
                    noPersonne = 4
                }else if noPersonne == 3 {
                    noPersonne = 5
                }
            }
            let question = Question()
        
            let verbeFrancais = VerbeFrancais(verbArray: arrayVerbe, n: noItem)
            let personneVerbe = Personne(verbArray: verbeFrancais)
            let verbeConjugue = question.finaleAleatoire(noPersonne: noPersonne, verbeFrancais: verbeFrancais, personneVerbe: personneVerbe)
            verbeFinal = verbeFrancais.verbe
            modeFinal = verbeFrancais.mode
            tempsFinal = verbeFrancais.temps
            choixPersonne = verbeConjugue[0]
            let personneChoisi = verbeConjugue[1]
            reponseBonne = verbeConjugue[2]
        
            let helper = Helper()
        tempsEtModeChoisi = [helper.capitalize(word: verbeFinal), helper.capitalize(word: modeFinal), helper.capitalize(word: tempsFinal), choixPersonne, personneChoisi, reponseBonne]
        return tempsEtModeChoisi
    }
    func choixTempsEtMode(arraySelection: [String]) -> [[String]]{
        print(arraySelection)
        for arraySelections in arraySelection{
            var n = 0
            tempsChoisi  = arraySelections
            print(tempsChoisi)
            while tempsChoisi.characters.last == " "{
                tempsChoisi = String(tempsChoisi.characters.dropLast(1))
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
