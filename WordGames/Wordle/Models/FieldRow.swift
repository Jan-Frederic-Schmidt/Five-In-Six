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
    
    func compareWords(_ comLetters: Array<String>) -> Array<String> {
        var mutableLetters: [String?] = comLetters
        var alreadyGuessed = [String]()
        
        for i in 0..<5 {
            if fields[i].guess == mutableLetters[i] {
                fields[i].color = .green
                mutableLetters[i] = nil
            }
        }
            
            isSolved = mutableLetters.allSatisfy ({ $0 == nil })
        
        for i in 0..<5 {
            if fields[i].color != .green {
                if mutableLetters.contains(fields[i].guess) {
                    fields[i].color = .orange
                    let j = mutableLetters.firstIndex(of: fields[i].guess)!
                    mutableLetters[j] = nil
                } else {
                    fields[i].color = .gray
                    alreadyGuessed.append(fields[i].guess)
                }
            }
        }
        
        return alreadyGuessed
    }
    
    func makeRealWord() -> String{
        var word = ""
        
        for field in fields{
            word += field.guess
        }
        
        return word
    }
}
