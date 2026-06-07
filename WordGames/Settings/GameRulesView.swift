//
//  GameRulesView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//

import SwiftUI

struct GameRulesView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("""
                    Wordle is a now-famous game developed by Josh Wardle and later bought by the New York Times.
                    
                    The game's main goal is simple: Guess a word by trying six other words. You enter one letter per field, all fields in a row then make up your word. Your word has to be real and part of the same pool of words as the target word. So, if your word isn't being recognized as such, it doesn't meet one of those criteria. 
                    
                    Afterward, the app evaluates your word: A green letter means it is located at the same spot in the target word, an orange letter means the target word does contain it, but not at that spot and a gray letter means it isn't in the target word at all. 
                    
                    You log your word in by pressing ⏎. You have six tries per target word or else you will lose your streak and the word will be revealed to you. 
                    """)
                }
                
                Section("Forbidden Letters") {
                    Text("ß")
                }
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Game Rules")
        }
    }
}
