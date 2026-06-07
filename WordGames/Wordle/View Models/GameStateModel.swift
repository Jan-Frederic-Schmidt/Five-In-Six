//
//  GameState.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//
import Combine
import Foundation

extension WordleGridView {
    class GameState: ObservableObject {
        @Published var chosenWord = ChosenWord()
        @Published var rows = [FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow(), FieldRow()]
        
        var guesses = 0
        var isSolved = false
        @Published var alreadyGuessed: Set<String> = Set([])
        
        var alertTitle = ""
        var alertMessage = ""
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
                if chosenWord.wordList.contains(row.makeRealWord()){
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
                alertTitle = "Richtig!"
                alertMessage = "Super, du hast \(chosenWord.word) erraten!"
                alertAction = {
                    stat.statistic.streak += 1
                    stat.statistic.timesPlayed += 1
                    stat.statistic.guessSpread.updateValue(stat.statistic.guessSpread[self.guesses, default: 0 ] + 1, forKey: self.guesses)
                    self.resetGame()
                }
                
                isSolved = true
            } else {
                if guesses >= 6 {
                    alertTitle = "Leider Falsch!"
                    alertMessage = "Das war leider falsch. Das Wort war \(chosenWord.word)"
                    alertAction = {
                        stat.statistic.streak = 0
                        stat.statistic.timesPlayed += 1
                        self.resetGame()
                    }
                    
                    isSolved = true
                }
            }
        }
    }
}
