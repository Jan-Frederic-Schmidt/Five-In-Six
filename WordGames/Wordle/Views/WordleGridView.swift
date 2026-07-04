//
//  RowView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/7/2026.
//

import TipKit
import SwiftUI

struct WordleGridView: View {
    @Environment(GameState.self) var gameState
    let shareTip = ShareTip()
    
    var body: some View{
        @Bindable var gameState = gameState
        
        VStack(spacing: 15) {
            
            Text("Already used letters: \n \(gameState.alreadyGuessed.sorted().joined(separator: " • "))")
                .font(.callout)
            Text(gameState.chosenWord.word)
            
            HStack {
                Spacer()
                
                Text("Streak: \(gameState.stat.streak)")
                
                Spacer()
            }
            .font(.title).bold()
            .buttonBorderShape(.circle)
            
            VStack(spacing: 5){
                ForEach($gameState.rows){$row in
                    WordleRowView(row: $row, action: gameState.checkWord)
                }
                .alert(gameState.alertTitle, isPresented: $gameState.isSolved) {
                    Button("Next round", action: gameState.alertAction)
                } message: {
                    Text(gameState.alertMessage)
                }
                .task {
                    if await !gameState.chosenWord.wordList.contains(gameState.chosenWord.word) {
                        gameState.resetGame()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: gameState.resetGame) {
                    Image(systemName: "arrow.trianglehead.counterclockwise")
                        .foregroundStyle(.white)
                        .bold()
                }
                .buttonStyle(.glassProminent).tint(.red)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // share the wordle instance
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
                .onTapGesture {
                    shareTip.invalidate(reason: .actionPerformed)
                }
                .popoverTip(shareTip)
            }
        }
    }
}
