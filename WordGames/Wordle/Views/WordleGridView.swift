//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import SwiftUI

struct WordleGridView: View {
    
    @ObservedObject public var gameState = GameState()
    
    var body: some View{
        VStack(spacing: 15) {
            
            Text("Already used letters: \n \(gameState.alreadyGuessed.sorted().joined(separator: " • "))")
                .font(.callout)
            Text(gameState.chosenWord.word)
            
            HStack {
                Button {
                    // share the wordle instance
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .buttonStyle(.glassProminent).tint(.green)
                
                Spacer()
                
                Text("Streak: \(stat.statistic.streak)")
                
                Spacer()
                
                Button(action: gameState.resetGame) {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                        .foregroundStyle(.white)
                }
                .buttonStyle(.glassProminent).tint(.red)
            }
            .font(.title).bold()
            .buttonBorderShape(.circle)
            
            VStack(spacing: 5){
                ForEach($gameState.rows){$row in
                    WordleRowView(row: $row) {
                        gameState.checkWord(row: row)
                    }
                }
                .alert(gameState.alertTitle, isPresented: $gameState.isSolved) {
                    Button("Next round", action: gameState.alertAction)
                } message: {
                    Text(gameState.alertMessage)
                }
                .onAppear {
                    if !gameState.chosenWord.wordList.contains(gameState.chosenWord.word) {
                        gameState.resetGame()
                    }
                }
            }
        }
    }
}
