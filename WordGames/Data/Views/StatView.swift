//
//  StatView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/1/26.
//
import Charts
import TipKit
import SwiftUI

struct StatView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
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
    
    @Environment(GameState.self) var gameState
    
    var body: some View {
        NavigationStack{
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        TipView(ChartTip())
                        
                        Chart{
                            ForEach(1..<7, id: \.self){number in
                                BarMark(
                                    x: .value("Number of Words who took that many guesses", gameState.stat.guessSpread[number]!),
                                    y: .value("Number of Tries", String(number))
                                )
                                .annotation(position: .trailing) {
                                    Text(gameState.stat.guessSpread[number]! != 0 ? String(gameState.stat.guessSpread[number]!) : "")
                                    }
                                        
                                }
                            }
                                .padding()
                                .chartYAxisLabel("Number of Rounds", alignment: .topLeading)
                                .chartXAxisLabel("Number of Tries")
                                .foregroundStyle(Color.accentColor)
                                .frame(maxWidth: .infinity, minHeight: verticalSizeClass == .compact ? 250 : 400)
                                .background(colorScheme == .light ? .white : .black)
                                .clipShape(.rect(cornerRadius: 20))
                                .shadow(radius: 5)
                        
                        HStack {
                            DataCard(data: "\(gameState.stat.timesPlayed)", description: "Times Played", color: .indigo, aspectRatio: 1/1, height: .infinity)
                            
                            Spacer()

                            DataCard(data: "\(gameState.stat.streak)", description: "Your Streak", color: .red, aspectRatio: 1/1, height: .infinity)
                        }
                        
                        DataCard(
                            data: "\(gameState.stat.firstPlayed?.formatted(date: .long, time: .omitted) ?? String(localized: "Not played yet"))",
                            description: "First Time Played",
                            color: .green,
                            aspectRatio: nil,
                            height: 200
                        )
                        
                        DataCard(
                            data: "\(gameState.stat.lastPlayed?.formatted(date: .long, time: .omitted) ?? String(localized: "Not played yet"))",
                            description: "Last Time Played",
                            color: .orange,
                            aspectRatio: nil,
                            height: 200
                        )
                    }
                    .padding([.horizontal, .bottom])
                    .frame(maxWidth: 650)
                    .frame(maxWidth: .infinity)
                }
                .navigationTitle(LocalizedStringKey("Statistics"))
            }
        }
    }
}

struct DataCard: View {
    struct clearDivider: View {
        var body: some View {
            Rectangle()
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
    
    let data: LocalizedStringKey
    let description: LocalizedStringKey
    let color: Color
    let aspectRatio: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        VStack {
            Text(data)
                .font(.largeTitle)
                .fontWeight(.heavy)
            clearDivider()
            Text(description)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: height)
        .aspectRatio(aspectRatio, contentMode: .fit)
        .background(color)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 5)
    }
}
