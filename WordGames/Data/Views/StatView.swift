//
//  StatView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/1/26.
//
import Charts
import SwiftUI

struct StatView: View {
    
    @State private var showingExplanation = false
    
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
    
    var body: some View {
        NavigationStack{
            ZStack {
                backgroundColor
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 20) {
                        HStack {
                            DataCard(data: "\(stat.statistic.timesPlayed)", description: "Times Played", color: .indigo, aspectRatio: 1/1, height: .infinity)
                            
                            Spacer()

                            DataCard(data: "\(stat.statistic.streak)", description: "Your Streak", color: .red, aspectRatio: 1/1, height: .infinity)
                        }
                        
                        DataCard(
                            data: "\(stat.statistic.firstPlayed?.formatted(date: .long, time: .omitted) ?? String(localized: "Not played yet"))",
                            description: "First Time Played",
                            color: .green,
                            aspectRatio: nil,
                            height: 200
                        )
                        
                        DataCard(
                            data: "\(stat.statistic.lastPlayed?.formatted(date: .long, time: .omitted) ?? String(localized: "Not played yet"))",
                            description: "Last Time Played",
                            color: .orange,
                            aspectRatio: nil,
                            height: 200
                        )
                        
                        DataCard(
                            data: "\(stat.statistic.consecutiveDays)",
                            description: "Consecutive Days Played",
                            color: .mint,
                            aspectRatio: nil,
                            height: 200
                        )
                        
                        Group{
                            if showingExplanation{
                                ChartExplanationView()
                            } else {
                                Chart{
                                    ForEach(1..<7, id: \.self){number in
                                        BarMark(
                                            x: .value("Number of Words who took that many guesses", stat.statistic.guessSpread[number]!),
                                            y: .value("Number of Tries", String(number))
                                        )
                                        .annotation(position: .trailing) {
                                            Text(stat.statistic.guessSpread[number]! != 0 ? String(stat.statistic.guessSpread[number]!) : "")
                                        }
                                        
                                    }
                                }
                                .chartYAxisLabel("Number of Rounds", alignment: .topLeading)
                                .chartXAxisLabel("Number of Tries")
                                .foregroundStyle(Color.accentColor)
                            }
                        }
                        .frame(maxWidth: .infinity, minHeight: 400)
                        .overlay(alignment: .topTrailing) {
                            Button{
                                withAnimation{
                                    showingExplanation.toggle()
                                }
                            } label: {
                                Image(systemName: showingExplanation ? "xmark" : "questionmark.circle")
                            }
                            .buttonStyle(.plain)
                            .foregroundStyle(Color.accentColor)
                        }
                        .padding()
                        .background(colorScheme == .light ? .white : .black)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(radius: 5)
                    }
                    .padding([.horizontal, .bottom])
                    .frame(maxWidth: 515)
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
