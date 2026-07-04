//
//  GameState.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//

import Combine
import Foundation
import SwiftUI

@Observable
    class GameState {
        var chosenWord = ChosenWord()
        var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        var stat = getStatistic()
        
        var guesses = 0
        var isSolved = false
         var alreadyGuessed: Set<String> = Set([])
        
        var alertTitle: LocalizedStringResource = ""
        var alertMessage: LocalizedStringResource = ""
        var alertAction = { }
        
        func resetGame(){
            if stat.firstPlayed == nil{
                stat.firstPlayed = .now
            }
            stat.lastPlayed = .now
            
            if let data = try? JSONEncoder().encode(stat){
                UserDefaults.standard.set(data, forKey: "Statistic")
            } else {
                fatalError("Couldn't save game")
            }
            
            rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
            Task {
                await chosenWord.chooseNewWord()
            }
            guesses = 0
            alreadyGuessed = Set([])
        }
        
        func checkWord(row: FieldRow) -> Bool {
            if !row.fields.contains(where: {$0.guess == ""}){
                if checkSpelling(row.makeRealWord()){
                    row.locked = true
                    guesses += 1
                    for char in row.compareWords(chosenWord.characterList) {
                        alreadyGuessed.insert(char)
                    }
                    setAlert(row.isSolved)
                    return true
                }
            }
            
            return false
        }
        
        func setAlert(_ isCorrect: Bool) {
            if isCorrect {
                alertTitle = "Correct!"
                alertMessage = "Great, you guessed \(chosenWord.word.localizedCapitalized)"
                alertAction = {
                    self.stat.streak += 1
                    self.stat.timesPlayed += 1
                    self.stat.guessSpread.updateValue(self.stat.guessSpread[self.guesses, default: 0 ] + 1, forKey: self.guesses)
                    self.resetGame()
                }
                
                isSolved = true
            } else {
                if guesses >= 6 {
                    alertTitle = "Incorrect!"
                    alertMessage = "Alas, that was wrong. The word was \(chosenWord.word.localizedCapitalized)"
                    alertAction = {
                        self.stat.streak = 0
                        self.stat.timesPlayed += 1
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
