//
//  ExtensionCapitalizedFirstLetter.swift
//  Spanish Verbs Quiz
//
//  Created by Normand Martin on 2019-02-25.
//  Copyright © 2019 Normand Martin. All rights reserved.
//

import Foundation
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
