//
//  LanguageCode.swift
//  WordGames
//
//  Created by Jan Schmidt on 8/1/26.
//

import Foundation
import SwiftUI

struct LanguageCode {
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    var code: String {
        if languageIdentifier == "auto" {
            if let languageIdentifer = Locale.current.language.languageCode?.identifier {
                 return languageIdentifer
            } else {
                 return "en"
            }
        } else {
            return languageIdentifier
        }
    }
}
