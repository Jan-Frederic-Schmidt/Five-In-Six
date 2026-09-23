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
    
//    --------Properties--------
    
    var chosenWord = ChosenWord("")
    var wordList = WordList()
    var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
    var stat: Statistic
        
    var maxTime = 0
    var timerRunning = false {
        didSet {
            if timerRunning == false {
                timerPaused = false
            }
        }
    }
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
    
//    --------Methods--------
    
    func importWord(_ word: String) {
        timerRunning = false
        resetGame()
        chosenWord = ChosenWord(word)
    }
    
    func chooseNewWord() -> ChosenWord {
        var newWord = wordList.list.randomElement()!
        while newWord == chosenWord.word || BlackList.general.list.contains(newWord) {
            newWord = wordList.list.randomElement()!
        }
        
        return ChosenWord(newWord)
    }
        
        func doNotShowAgain() {
            BlackList.general.list.append(chosenWord.word)
            print("\(BlackList.general.list) is on the Blacklist")
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
        chosenWord = chooseNewWord()
        guesses = 0
        alreadyGuessed = Set([])
    }
    
    func checkWord(row: FieldRow) -> Bool {
        if !row.fields.contains(where: {$0.guess == ""}){
            if SpellChecker.checkSpelling(row.makeRealWord(), in: LanguageCode().code) {
                print(chosenWord.word)
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
            alertMessage = timerRunning ? "Great, you guessed \"\(chosenWord.word.localizedCapitalized)\"! It took you \(maxTime) seconds!" : "Great, you guessed \"\(chosenWord.word.localizedCapitalized)\"!"
            alertAction = {
                self.stat.streak += 1
                self.stat.timesPlayed += 1
                
                self.stat.guessSpread[self.guesses, default: 0] += 1
                self.resetGame()
            }
            
            timerRunning = false
            isSolved = true
        } else {
            if guesses >= 6 || overwriteGuessCount {
                alertTitle = "Incorrect!"
                alertMessage = timerRunning && maxTime <= 0 ? "Not fast enough! The word was \"\(chosenWord.word.localizedCapitalized)\"" : "Alas, that was wrong. The word was \"\(chosenWord.word.localizedCapitalized)\""
                alertAction = {
                    self.stat.streak = 0
                    self.stat.timesPlayed += 1
                    self.resetGame()
                }
                
                timerRunning = false
                isSolved = true
            }
        }
    }
}

