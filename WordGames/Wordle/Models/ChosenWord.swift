//
//  ChosenWord.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/15/26.
//

import Foundation
import SwiftUI

class ChosenWord{
    
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    
     var wordList: Set<String> {
        if languageIdentifier == "auto" {
            if let languageCode = Locale.current.language.languageCode?.identifier {
               return Bundle.main.chooseWord(for: "wordlist", language: languageCode, withLenght: 5)
            } else {
               return Bundle.main.chooseWord(for: "wordlist", language: "en", withLenght: 5)
            }
        } else {
           return Bundle.main.chooseWord(for: "wordlist", language: languageIdentifier, withLenght: 5)
        }
    }
    
    var word = "" {
        didSet{
            characterList = Array(word).convertToStrings()
        }
    }
    
    var characterList: Array<String>
    
    init(_ wordlist: String) {
        characterList = Array(word).convertToStrings()
    }
    
    func chooseNewWord(){
        var newWord = wordList.randomElement()!
        while newWord == word{
            newWord = wordList.randomElement()!
        }
        word = newWord
    }
}
