//
//  ChosenWord.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/15/26.
//

import Foundation
import SwiftUI

class ChosenWord {
    
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    var languageCode: String {
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
    
    var wordList: Set<String> {
        get async {
            return await Bundle.main.chooseWord(for: "wordlist", language: languageCode, withLenght: 5)
        }
    }
    
    var word = "" {
        didSet{
            characterList = Array(word).convertToString()
            
            let data = word.data(using: .utf8)!
            hexWord = data.map { String(format: "%02x", $0) }.joined()
        }
    }
    
    var hexWord = ""
    
    var characterList = [String]()
    
    func chooseNewWord() async {
        var newWord = await wordList.randomElement()!
        while newWord == word || BlackList.list.contains(newWord) {
            newWord = await wordList.randomElement()!
        }
        
        word = newWord
    }
}
