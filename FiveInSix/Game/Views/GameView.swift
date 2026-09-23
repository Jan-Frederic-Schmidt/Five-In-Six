//
//  WordleView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/20/26.
//

import Combine
import SwiftUI
import TipKit

struct GameView: View {
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

    @State private var showingTimeSelector = false
    @State private var showingWordImportingScreen = false
    @Environment(GameState.self) var gameState
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        @Bindable var gameState = gameState
        
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 30){
                        Text("5in6!")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                        
                        VStack(spacing: 15) {
                            
                            Text("Already used letters: \n \(gameState.alreadyGuessed.sorted().joined(separator: " • "))")
                                .font(.callout)
//                            Text(gameState.chosenWord.word)
                            
                            HStack {
                                Spacer()
                                
                                Text("Streak: \(gameState.stat.streak)")
                                
                                Spacer()
                            }
                            .font(.title).bold()
                        }
                        
                        GameGridView()
                            .onReceive(timer) { _ in gameState.listenToTimer() }
                            .disabled(gameState.timerRunning && gameState.timerPaused)
                    }
                    .padding([.horizontal, .bottom], 20)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollDismissesKeyboard(.interactively)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Reset game", systemImage: "arrow.counterclockwise") {
                        gameState.resetGame()
                        gameState.stat.streak = 0
                    }
                        .disabled(gameState.timerRunning)
                    
                    Button("Import word from code", systemImage: "square.and.arrow.down") {
                        showingWordImportingScreen = true
                    }
                        .disabled(gameState.timerRunning)
                }
                
                if gameState.timerRunning {
                    let (m, s) = gameState.maxTime.quotientAndRemainder(dividingBy: 60)
                    
                    ToolbarItem(placement: .title) {
                        Text(m != 0 ? "\(m)m\(s)s" : "\(s)s")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !gameState.timerRunning {
                        Button("Choose duration", systemImage: "stopwatch") {
                            showingTimeSelector = true
                        }
                    } else {
                        Button("Pause timer", systemImage: gameState.timerPaused ? "play.fill" : "pause.fill") {
                            gameState.timerPaused.toggle()
                        }
                    }
                    
                    ShareLink("Share this word", item: gameState.chosenWord.hexWord)
                        .buttonStyle(.plain)
                        .popoverTip(ShareTip())
                }
            }
            .sheet(isPresented: $showingTimeSelector) {
                TimeSelectorView(maxTime: $gameState.maxTime, useTimer: $gameState.timerRunning)
                    .presentationDetents([.medium])
            }
            .sheet(isPresented: $showingWordImportingScreen) {
                WordImportingView()
                    .presentationDetents([.height(200)])
            }
        }
    }
}
