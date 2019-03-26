//
//  ChoixFacileVerbeConjugue.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-28.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
class ChoixFacileVerbeConjugue {
    class func verbeConjugue(arrayVerbe: [[String]], infinitif: String, tempsDuVerbe: String, modeDuverbe: String, verbHintButton: [UIButton], hintMenuAction: () -> Void, reponseBonne: String) {
        var verbeChoisiEtConjugue = [String]()
        var auxiliereArray = [String]()
        var infinitifMutate = infinitif.lowercased()
        for verb in arrayVerbe{
            if verb.contains(infinitifMutate)  && verb.contains(tempsDuVerbe)  && verb.contains(modeDuverbe) {
                verbeChoisiEtConjugue.append(verb[3])
                verbeChoisiEtConjugue.append(verb[4])
                verbeChoisiEtConjugue.append(verb[5])
                verbeChoisiEtConjugue.append(verb[6])
                verbeChoisiEtConjugue.append(verb[7])
                verbeChoisiEtConjugue.append(verb[8])
                break
            }
        }
        if verbeChoisiEtConjugue == [] {
            infinitifMutate = infinitifMutate.removingReflexivePronom()
        }
        var mutateReponseBonne = reponseBonne
        hintMenuAction()
        for verb in arrayVerbe{
            if verb.contains(infinitifMutate)  && verb.contains(tempsDuVerbe)  && verb.contains(modeDuverbe) &&  verbeChoisiEtConjugue == []{
                verbeChoisiEtConjugue.append(verb[3])
                verbeChoisiEtConjugue.append(verb[4])
                verbeChoisiEtConjugue.append(verb[5])
                verbeChoisiEtConjugue.append(verb[6])
                verbeChoisiEtConjugue.append(verb[7])
                verbeChoisiEtConjugue.append(verb[8])
                break
            }
        }
        verbeChoisiEtConjugue = AuxiliereAvoirToEtre.auxiliereFromAvoirToEtre(reponseBonne: reponseBonne, verbeChoisiEtConjugue: verbeChoisiEtConjugue)
        var participe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).last!
        for n in 0...5{
            auxiliereArray.append(verbeChoisiEtConjugue[n].components(separatedBy: .whitespaces).first!)
        }
        let terminaison = mutateReponseBonne.detectFeminin(participe: participe)
        let nbVerbe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces)
        if nbVerbe.count >= 2{
            verbeChoisiEtConjugue[0] = auxiliereArray[0] + " " + participe + terminaison.0
            verbeChoisiEtConjugue[1] = auxiliereArray[1] + " " +  participe + terminaison.1
            verbeChoisiEtConjugue[2] = auxiliereArray[2] + " " +  participe + terminaison.2
            verbeChoisiEtConjugue[3] = auxiliereArray[3] + " " +  participe + terminaison.3
            verbeChoisiEtConjugue[4] = auxiliereArray[4] + " " +  participe + terminaison.4
            verbeChoisiEtConjugue[5] = auxiliereArray[5] + " " +  participe + terminaison.5
            
        }
        if(infinitif.caseInsensitiveCompare(infinitifMutate) != .orderedSame){
            let participeHolder = participe
            if participe.premiereLettreIsVoyelle() || auxiliereArray[0].premiereLettreIsVoyelle(){
                verbeChoisiEtConjugue[0] = "m'\(verbeChoisiEtConjugue[0])"
            }else{
                verbeChoisiEtConjugue[0] = "me \(verbeChoisiEtConjugue[0])"
            }
            participe = participeHolder
            if participe.premiereLettreIsVoyelle() || auxiliereArray[1].premiereLettreIsVoyelle(){
                verbeChoisiEtConjugue[1] = "t'\(verbeChoisiEtConjugue[1])"
            }else{
                verbeChoisiEtConjugue[1] = "te \(verbeChoisiEtConjugue[1])"
            }
            participe = participeHolder
            if participe.premiereLettreIsVoyelle() || auxiliereArray[2].premiereLettreIsVoyelle(){
                verbeChoisiEtConjugue[2] = "s'\(verbeChoisiEtConjugue[2])"
            }else{
                verbeChoisiEtConjugue[2] = "se \(verbeChoisiEtConjugue[2])"
            }
            participe = participeHolder
            if participe.premiereLettreIsVoyelle() || auxiliereArray[5].premiereLettreIsVoyelle(){
                verbeChoisiEtConjugue[5] = "s'\(verbeChoisiEtConjugue[5])"
            }else{
                verbeChoisiEtConjugue[5] = "se \(verbeChoisiEtConjugue[5])"
            }
            verbeChoisiEtConjugue[3] = "nous \(verbeChoisiEtConjugue[3])"
            verbeChoisiEtConjugue[4] = "vous \(verbeChoisiEtConjugue[4])"
            
        }
        mutateReponseBonne = reponseBonne
        for n in 0...5{
            if verbeChoisiEtConjugue[n].components(separatedBy: .whitespaces).first! == mutateReponseBonne.components(separatedBy: .whitespaces).first! {
                verbeChoisiEtConjugue[n] = reponseBonne
                break
            }
        }

        verbeChoisiEtConjugue = verbeChoisiEtConjugue.filter {$0 != ""}
        verbeChoisiEtConjugue = Array(Set(verbeChoisiEtConjugue))
        let noItem = verbeChoisiEtConjugue.count
        switch noItem {
        case 1:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].isHidden = true
            verbHintButton[2].isHidden = true
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
        case 2:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].isHidden = true
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
            
        case 3:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].isHidden = true
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true
        case 4:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].isHidden = true
            verbHintButton[5].isHidden = true

        case 5:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].setTitle(verbeChoisiEtConjugue[4], for: .normal)
            verbHintButton[5].isHidden = true
        case 6:
            verbHintButton[0].setTitle(verbeChoisiEtConjugue[0], for: .normal)
            verbHintButton[1].setTitle(verbeChoisiEtConjugue[1], for: .normal)
            verbHintButton[2].setTitle(verbeChoisiEtConjugue[2], for: .normal)
            verbHintButton[3].setTitle(verbeChoisiEtConjugue[3], for: .normal)
            verbHintButton[4].setTitle(verbeChoisiEtConjugue[4], for: .normal)
            verbHintButton[5].setTitle(verbeChoisiEtConjugue[5], for: .normal)

        default:
            break
        }
    }

}
extension String {
    mutating func removingReflexivePronom() -> String{
        if  self.contains("'"){
            self  = String(self.dropFirst())
            self = String(self.dropFirst())
            return self
        }else{
            let arrayVerb = self.components(separatedBy: " ")
            if arrayVerb[0] == "me" || arrayVerb[0] == "te" || arrayVerb[0] == "se" || arrayVerb[0] == "nous" || arrayVerb[0] == "vous"{
                self = arrayVerb.dropFirst().joined()
            }
            return self
        }
    }
}

extension String {
    mutating func detectFeminin(participe: String) -> (String, String, String, String, String, String){
        var verbeConjugue = ("", "", "", "", "", "")
        var verbArray = [String]()
        var arrayOfLastLetters = [Character]()
        var verbeMutated = String()
        let isReflexive = self.isVerbeReflexive()
        if isReflexive{
            if self.contains("'"){
                self = String(self.dropFirst())
                self = String(self.dropFirst())
                verbeMutated = self
            }else {
                verbArray = Array(self.components(separatedBy: .whitespaces).dropFirst())
                 verbeMutated = verbArray.last!
            }
        }else{
            verbArray = self.components(separatedBy: .whitespaces)
             verbeMutated = verbArray.last!
        }
        
       
        if  verbArray.count >= 2 {
            while participe != verbeMutated{
                arrayOfLastLetters.append(verbeMutated.removeLast())
                _ = String(verbeMutated.dropLast())
            }
        }
        if arrayOfLastLetters.contains("e"){
            verbeConjugue = ("e", "e", "e","es","es","es")
        }
        return verbeConjugue
    }
}
extension String {
    func isVerbeReflexive() -> Bool{
        var isReflexive = false
        let pronom = self.components(separatedBy: .whitespaces).first
        let pronomApostrophe = self.components(separatedBy: "'").first
        if pronom == "me" || pronom == "te" || pronom == "se" || pronom == "nous" || pronom == "vous" || pronom == "se" || pronomApostrophe == "m" || pronomApostrophe == "t" || pronomApostrophe == "s"{
            isReflexive = true
        }
        return isReflexive
    }
    
}
extension String {
    mutating func premiereLettreIsVoyelle() -> Bool {
        let firstLetter = self.removeFirst()
        var firstLetterIsVoyelle = Bool()
        if firstLetter == "i" || firstLetter == "a" || firstLetter == "e" || firstLetter == "i" || firstLetter == "o" || firstLetter == "u" || firstLetter == "y"{
            firstLetterIsVoyelle = true
        }
        return firstLetterIsVoyelle
    }
}

class AuxiliereAvoirToEtre {
    class func auxiliereFromAvoirToEtre(reponseBonne: String, verbeChoisiEtConjugue: [String]) -> [String]{
        var mutateReponseBonne = reponseBonne
        var verbeChoisi = [String]()
        var auxiliereEtre = [String]()
        var isNotPassiveVerb = Bool()
        mutateReponseBonne = mutateReponseBonne.removingReflexivePronom()
        let auxiliereReponseBonne = mutateReponseBonne.components(separatedBy: .whitespaces).first!
        let participe = verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).last!
        var verbeAComparerArray = verbeChoisiEtConjugue
        for n in 0...5 {
            var verbeAcomparer = verbeAComparerArray[n].removingReflexivePronom()
            verbeAcomparer = verbeAcomparer.components(separatedBy: .whitespaces).first!
            if (verbeAcomparer.caseInsensitiveCompare(auxiliereReponseBonne) == .orderedSame) {
                isNotPassiveVerb = true
            }
        }
        if isNotPassiveVerb == false {
            let dicAuxiliere = Auxiliere.getDict()
            for dic in dicAuxiliere{
                if dic.key == verbeChoisiEtConjugue[0].components(separatedBy: .whitespaces).first!{
                    auxiliereEtre = dic.value
                }
            }
            verbeChoisi.append(auxiliereEtre[0] + " " + participe)
            verbeChoisi.append(auxiliereEtre[1] + " " + participe)
            verbeChoisi.append(auxiliereEtre[2] + " " + participe)
            verbeChoisi.append(auxiliereEtre[3] + " " + participe)
            verbeChoisi.append(auxiliereEtre[4] + " " + participe)
            verbeChoisi.append(auxiliereEtre[5] + " " + participe)
        }else{
            verbeChoisi = verbeChoisiEtConjugue
        }
        return verbeChoisi
    }
}
