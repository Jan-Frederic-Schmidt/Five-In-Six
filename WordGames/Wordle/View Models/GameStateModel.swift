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
    var stat: Statistic
        
        var maxTime = 0 {
            willSet {
                if maxTime == 0 {
                    resetGame()
                }
            }
        }
    
        var timerRunning = false
        var timerPaused = false
        
        var guesses = 0
        var isSolved = false
        var alreadyGuessed: Set<String> = Set([])
        
        var alertTitle: LocalizedStringResource = ""
        var alertMessage: LocalizedStringResource = ""
        var alertAction = { }
        
        init() {
            do {
                stat = try Statistic.load()
            } catch {
                stat = Statistic()
            }
        }
        
        func checkWord(row: FieldRow) -> Bool {
            if !row.fields.contains(where: {$0.guess == ""}){
                if SpellChecker.checkSpelling(row.makeRealWord(), in: chosenWord.languageCode) {
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
        
        func setAlert(_ isCorrect: Bool, overwriteGuessCount: Bool = false) {
            if isCorrect {
                alertTitle = "Correct!"
                alertMessage = "Great, you guessed \(chosenWord.word.localizedCapitalized)"
                alertAction = {
                    self.stat.streak += 1
                    self.stat.timesPlayed += 1
                    
                    // The following is necessary, as simply updating the value inside the stat.guessSpread dictionary doesn't cause the graph to reload
                    var newGuessSpread = self.stat.guessSpread
                    newGuessSpread[self.guesses, default: 0] += 1
                    self.stat.guessSpread = newGuessSpread
                    
//                    self.stat.guessSpread[self.guesses, default: 0] += 1
                    self.resetGame()
                }
                
                isSolved = true
            } else {
                if guesses >= 6 || overwriteGuessCount {
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
        
        func doNotShowAgain() {
            BlackList.list.append(chosenWord.word)
            print("\(BlackList.list) is on the Blacklist")
            stat.streak = 0
            stat.timesPlayed = 0
            resetGame()
        }
        
        func listenToTimer() {
            if timerRunning && !timerPaused {
                if maxTime > 0 {
                    maxTime -= 1
                } else {
                    setAlert(false, overwriteGuessCount: true)
                    timerRunning = false
                    maxTime = 0
                }
            }
        }
    
    func resetGame(){
        if stat.firstPlayed == nil{
            stat.firstPlayed = .now
        }
        stat.lastPlayed = .now
        
        do {
            try Statistic.save(stat)
        } catch {
            fatalError("Could not save statistic")
        }
        
        rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        Task {
            await chosenWord.chooseNewWord()
        }
        timerRunning = false
        guesses = 0
        alreadyGuessed = Set([])
    }
}

