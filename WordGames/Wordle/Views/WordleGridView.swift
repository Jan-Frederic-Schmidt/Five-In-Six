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
            
            Text("Bereits genutzte Buchstaben: \n" + gameState.alreadyGuessed.sorted().joined(separator: " • "))
                .font(.callout)
            
            VStack(spacing: 5){
                ForEach($gameState.rows){$row in
                    WordleFieldView(row: $row)
                        .onSubmit {
                            gameState.checkWord(row: row)
                        }
                }
                .alert(gameState.alertTitle, isPresented: $gameState.isSolved) {
                    Button("Nächste Runde", action: gameState.alertAction)
                } message: {
                    Text(gameState.alertMessage)
                }
                
            }
        }
    }
}
