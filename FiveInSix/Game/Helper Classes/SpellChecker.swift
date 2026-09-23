//
//  SpellChecker.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/9/26.
//

import Foundation
import SwiftUI

struct SpellChecker {
    static func checkSpelling(_ rawWord: String, in language: String) -> Bool {
        let word = rawWord.capitalized
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: language)
        
        return misspelledRange.location == NSNotFound
    }
}
