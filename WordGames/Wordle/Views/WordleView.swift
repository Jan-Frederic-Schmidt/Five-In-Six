//
//  WordleView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/20/26.
//
import Combine
import SwiftUI

struct WordleView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var backgroundColor: Color {
        switch colorScheme {
        case .light:
            return Color.lightBackground
        case .dark:
            return Color.darkBackground
        default:
            return Color.lightBackground
        }
    }
    
    @State private var wordleGrid = WordleGridView()
    
    var body: some View {
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 30){
                        
                        Text("Wordle!")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                            .padding(.top)
                        
                        wordleGrid
                    }
                    .padding(.horizontal, 20)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
            }
            .onAppear {
                if wordleGrid.gameState.chosenWord.word.isEmpty {
                    wordleGrid.gameState.chosenWord.word = wordleGrid.gameState.chosenWord.wordList.randomElement()!
                }
            }
        }
    }
}
