//
//  ChoixFacileVerbeConjugue.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2018-11-28.
//  Copyright © 2018 Normand Martin. All rights reserved.
//

import UIKit
class ChoixFacileVerbeConjugue {
    class func verbeConjugue(arrayVerbe: [[String]], infinitif: String, tempsDuVerbe: String, modeDuverbe: String, verbHintButton: [UIButton], hintMenuAction: () -> Void ) {
        var verbeChoisiEtConjugue = [String]()
        var infinitifMutate = infinitif.lowercased()
        infinitifMutate = infinitifMutate.removingReflexivePronom()
        hintMenuAction()
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
        if(infinitif.caseInsensitiveCompare(infinitifMutate) != .orderedSame){
            verbeChoisiEtConjugue[0] = "me \(verbeChoisiEtConjugue[0])"
            verbeChoisiEtConjugue[1] = "te \(verbeChoisiEtConjugue[1])"
            verbeChoisiEtConjugue[2] = "se \(verbeChoisiEtConjugue[2])"
            verbeChoisiEtConjugue[3] = "nous \(verbeChoisiEtConjugue[3])"
            verbeChoisiEtConjugue[4] = "vous \(verbeChoisiEtConjugue[4])"
            verbeChoisiEtConjugue[5] = "se \(verbeChoisiEtConjugue[5])"
        }
        verbeChoisiEtConjugue = verbeChoisiEtConjugue.filter {$0 != ""}
        verbeChoisiEtConjugue = Array(Set(verbeChoisiEtConjugue))
        //verbeChoisiEtConjugue.shuffle()
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
        while self.contains(" "){
            self = String(self.dropFirst())
        }
        return self
    }
}

