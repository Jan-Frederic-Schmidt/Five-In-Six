//
//  StatView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/1/26.
//
//import Charts
//import SwiftUI
//
//struct StatView: View {
//    
//    @State private var showingExplanation = false
//    
//    @Environment(\.colorScheme) var colorScheme
//    
//    var body: some View {
//        NavigationStack{
//            Form{
//                Section{
//                    Text("\(stat.statistic.timesPlayed) Mal gespielt")
//                    Text("Du hast eine Streak von \(stat.statistic.streak)")
//                }
//                
//                Text("Erstes Mal gespielt: \(stat.statistic.firstPlayed?.formatted(date: .long, time: .omitted) ?? "Noch nicht gespielt")")
//                Text("Letztes Mal gespielt: \(stat.statistic.lastPlayed?.formatted(date: .long, time: .omitted) ?? "Noch nicht gespielt")")
//                Text("Du hast \(stat.statistic.consecutiveDays) Tage hintereinander gespielt")
//                
//                Section("Benötigte Versuche"){
//                    Group{
//                        if showingExplanation{
//                            ChartExplanationView()
//                        } else {
//                            Chart{
//                                ForEach(1..<7, id: \.self){number in
//                                    BarMark(
//                                        x: .value("Wörter, die so viele Versuche gebrauht haben", stat.statistic.guessSpread[number]!),
//                                        y: .value("Anzahl der Versuche", String(number))
//                                    )
//                                    .annotation(position: .trailing) {
//                                        Text(stat.statistic.guessSpread[number]! != 0 ? String(stat.statistic.guessSpread[number]!) : "")
//                                    }
//                                    
//                                }
//                            }
//                            .chartYAxisLabel("Zahl der Spiele", alignment: .topLeading)
//                            .chartXAxisLabel("Zahl der Versuche")
//                            .foregroundStyle(Color.accentColor)
//                        }
//                    }
//                    .frame(height: 400)
//                    .overlay(alignment: .topTrailing) {
//                        Button{
//                            withAnimation{
//                                showingExplanation.toggle()
//                            }
//                        } label: {
//                            Image(systemName: showingExplanation ? "xmark" : "questionmark.circle")
//                        }
//                        .buttonStyle(.plain)
//                        .foregroundStyle(Color.accentColor)
//                    }
//
//                }
//            }
//            .background(colorScheme == .light ? .lightBackground : .darkBackground)
//            .scrollContentBackground(.hidden)
//            .navigationTitle("Statistiken")
//        }
//    }
//}
