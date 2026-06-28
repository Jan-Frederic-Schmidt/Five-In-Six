//
//  GameState.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//

import Combine
import Foundation
import SwiftUI

extension WordleGridView {
    class GameState: ObservableObject {
        @Published var chosenWord = ChosenWord()
        @Published var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        
        var guesses = 0
        var isSolved = false
        @Published var alreadyGuessed: Set<String> = Set([])
        
        var alertTitle: LocalizedStringResource = ""
        var alertMessage: LocalizedStringResource = ""
        var alertAction = { }
        
        func resetGame(){
            if stat.statistic.firstPlayed == nil{
                stat.statistic.firstPlayed = .now
            }
            stat.statistic.lastPlayed = .now
            
            if let data = try? JSONEncoder().encode(stat.statistic){
                UserDefaults.standard.set(data, forKey: "Statistic")
            } else {
                fatalError("Couldn't save game")
            }
            
            rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
            chosenWord.chooseNewWord()
            guesses = 0
            alreadyGuessed = Set([])
        }
        
        func checkWord(row: FieldRow){
            if !row.fields.contains(where: {$0.guess == ""}){
                if checkSpelling(row.makeRealWord()){
                    row.locked = true
                    guesses += 1
                    for char in row.compareWords(chosenWord.characterList) {
                        alreadyGuessed.insert(char)
                    }
                    setAlert(row.isSolved)
                }
            }
        }
        
        func setAlert(_ isCorrect: Bool) {
            if isCorrect {
                alertTitle = "Correct!"
                alertMessage = "Great, you guessed \(chosenWord.word.localizedCapitalized)"
                alertAction = {
                    stat.statistic.streak += 1
                    stat.statistic.timesPlayed += 1
                    stat.statistic.guessSpread.updateValue(stat.statistic.guessSpread[self.guesses, default: 0 ] + 1, forKey: self.guesses)
                    self.resetGame()
                }
                
                isSolved = true
            } else {
                if guesses >= 6 {
                    alertTitle = "Incorrect!"
                    alertMessage = "Alas, that was wrong. The word was \(chosenWord.word.localizedCapitalized)"
                    alertAction = {
                        stat.statistic.streak = 0
                        stat.statistic.timesPlayed += 1
                        self.resetGame()
                    }
                    
                    isSolved = true
                }
            }
        }
        
        func checkSpelling(_ rawWord: String) -> Bool {
            let word = rawWord.capitalized
            let checker = UITextChecker()
            
            let range = NSRange(location: 0, length: word.utf16.count)
            
            var language = ""
            if chosenWord.languageIdentifier == "auto" {
                if let languageIdentifer = Locale.current.language.languageCode?.identifier {
                    language = languageIdentifer
                } else {
                    language = "en"
                }
            } else {
                language = chosenWord.languageIdentifier
            }
            
            let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: language)
            
            return misspelledRange.location == NSNotFound
        }
    }
}
