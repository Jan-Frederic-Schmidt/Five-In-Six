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
                    VStack(spacing: 40){
                        Text("Streak: \(stat.statistic.streak)")
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .padding(.top, 75)
                        //                        Text(viewModel.chosenWord.word)
                        VStack(spacing: 15){
                            wordleGrid
                        }
                    }
                    .padding(.horizontal, 35)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
                .navigationTitle("Wordle")
                .toolbar{
                    Button("Neues Wort wählen", action: wordleGrid.gameState.resetGame)
                }
            }
        }
    }
}
