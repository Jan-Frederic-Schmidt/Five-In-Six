//
//  Statistic.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/1/26.
//

import Foundation

@Observable
class Statistic: Codable {
    var lastPlayed: Date? = nil //Set when playing a game in resetGame function
    var firstPlayed: Date? = nil // same as above, but only if it is nil
    
    var averageGuesses: Int {
        let mostOftenGuessed = guessSpread.max { a, b in
            a.value < b.value
        }
        
        return mostOftenGuessed?.value ?? 0
        
    } //calculated (but how?)
    var streak = 0 //Set if a game was won if
    var timesPlayed = 0 //added to in resetGame function
    
    var guessSpread = [
        1: 0,
        2: 0,
        3: 0,
        4: 0,
        5: 0,
        6: 0
    ]
}

@Observable
class StatisticState{
    var statistic = getStatistic()
}

var stat = StatisticState()
