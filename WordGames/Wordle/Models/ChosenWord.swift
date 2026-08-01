//
//  ChosenWord.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/15/26.
//

import Foundation
import SwiftUI

struct ChosenWord {
    var word: String
    
    var hexWord = ""
    
    var characterList = [String]()
    
    init(_ word: String) {
        self.word = word
        
        self.characterList = Array(word).convertToString()
        
        let data = word.data(using: .utf8)!
        self.hexWord = data.map { String(format: "%02x", $0) }.joined()
    }
}
