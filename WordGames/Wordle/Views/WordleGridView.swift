//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI

struct WordleGridView: View {
    @Environment(GameState.self) var gameState
    
    var body: some View{
        @Bindable var gameState = gameState
        
            VStack(spacing: 5){
                ForEach($gameState.rows){$row in
                    WordleRowView(row: $row, action: gameState.checkWord)
                }
                .alert(gameState.alertTitle, isPresented: $gameState.isSolved) {
                    Button("Next round", action: gameState.alertAction)
                    
                    if gameState.guesses >= 6 {
                        Button("Don't show again", action: gameState.doNotShowAgain)
                    }
                } message: {
                    Text(gameState.alertMessage)
                }
                .task {
                    if await !gameState.chosenWord.wordList.contains(gameState.chosenWord.word) && !gameState.chosenWord.word.isEmpty{
                        gameState.resetGame()
                    }
                }
            }
        }
    }
