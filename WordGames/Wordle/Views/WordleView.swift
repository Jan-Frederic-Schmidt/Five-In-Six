//
//  WordleView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/20/26.
//

import Combine
import SwiftUI
import TipKit

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
    
    @State private var showingTimeSelector = false
    @Environment(GameState.self) var gameState
    let shareTip = ShareTip()
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        @Bindable var gameState = gameState
        
        NavigationStack{
            ZStack{
                backgroundColor
                    .ignoresSafeArea()
                ScrollView{
                    VStack(spacing: 30){
                        
                        Text("Wordle!")
                            .font(.system(size: 50))
                            .fontWeight(.black)
                        
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
                        }
                        
                        WordleGridView()
                            .onReceive(timer) { _ in gameState.listenToTimer() }
                    }
                    .padding([.horizontal, .bottom], 20)
                    .frame(maxWidth: .infinity)
                }
                .scrollBounceBehavior(.basedOnSize)
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
                
                if gameState.timerRunning {
                    let (m, s) = gameState.maxTime.quotientAndRemainder(dividingBy: 60)
                    
                    ToolbarItem(placement: .title) {
                        Text("\(m)m\(s)s")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Choose time", systemImage: "stopwatch") {
                        showingTimeSelector = true
                    }
                    .disabled(gameState.timerRunning)
                    
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
            .sheet(isPresented: $showingTimeSelector) {
                TimeSelectorView(maxTime: $gameState.maxTime, useTimer: $gameState.timerRunning)
                    .presentationDetents([.height(350)])
            }
        }
    }
}
