//
//  WordList.swift
//  WordGames
//
//  Created by Jan Schmidt on 8/1/26.
//

import Foundation
import SwiftUI

struct WordList {
    func getWordList(withLenght length: Int) -> Set<String> {
        if let wordlistURL = Bundle.main.url(forResource: "wordlist-\(LanguageCode().code).txt", withExtension: nil){
            if let wordlist = try? String(contentsOf: wordlistURL, encoding: .utf8) {
                    
                let allWords = wordlist.components(separatedBy: .newlines)
                    
                return Set(allWords.filter { $0.count == length && !$0.localizedStandardContains("ß")})
                    
                } else {
                    fatalError("Could not import list of words")
                }
            } else {
                fatalError("Could not find list of words")
            }
        }
    
    var list: Set<String> {
        return getWordList(withLenght: 5)
    }
}
