//
//  FieldStruct.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import Foundation
import SwiftUI

@Observable
class FieldRow: Identifiable{
    class Field{
        var guess: String = ""{
            didSet{
                guess = guess.uppercased()
            }
        }
        var color = Color.white.opacity(0)
    }
    
    var id = UUID()
    var fields = [Field(), Field(), Field(), Field(), Field()]
    var locked = false
    var isSolved = false
    
    //THE FOLLOWING FUNCTION WAS MADE BY AI, SADLY
    
    func compareWords(_ comLetters: Array<String>) -> Array<String> {
        var unmatchedTargetCounts = [String: Int]()
        var alreadyGuessed = [String]()

        // First pass: Mark green (correct position)
        for i in 0..<5 {
            if comLetters[i] == fields[i].guess {
                fields[i].color = .green
            } else {
                unmatchedTargetCounts[comLetters[i], default: 0] += 1
            }
        }

        isSolved = fields.allSatisfy { $0.color == .green }

        // Second pass: Mark orange or gray
        for i in 0..<5 {
            guard fields[i].color != .green else { continue }
            let guess = fields[i].guess
            if let count = unmatchedTargetCounts[guess], count > 0 {
                fields[i].color = .orange
                unmatchedTargetCounts[guess]! -= 1
            } else {
                fields[i].color = .gray
                alreadyGuessed.append(guess)
            }
        }
        
        return alreadyGuessed
    }
    
    //End of AI
    func makeRealWord() -> String{
        var word = ""
        
        for field in fields{
            word += field.guess
        }
        
        return word
    }
}
