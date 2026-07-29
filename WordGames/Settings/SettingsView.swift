//
//  SettingsView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/8/26.
//

//Color Theme, About, Game Rules, Clear All Data, Language

import SwiftUI

struct SettingsView: View {
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    @AppStorage("colorScheme") var storedColorScheme = 0
    @AppStorage("showExclamationmarkWhenDifferentiateWithoutColor") var showExclamationmarkWhenDifferentiateWithoutColor = false
    @AppStorage("useSerifs") var useSerifs = true
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    
    @Environment(GameState.self) var gameState
    
    @State private var showAlert = false
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink {
                    GameRulesView()
                } label: {
                    Label("Game Rules", systemImage: "text.page")
                }
                
                Section{
                    Toggle("Use serif font", isOn: $useSerifs)
                    
                    if accessibilityDifferentiateWithoutColor {
                        Toggle("Show exclamation mark", isOn: $showExclamationmarkWhenDifferentiateWithoutColor)
                    }
                    
                    Picker(selection: $storedColorScheme){
                        ForEach(0..<3){
                            switch $0{
                            case 0:
                                Text("Device")
                                    .tag($0)
                            case 1:
                                Text("Light")
                                    .tag($0)
                            default:
                                Text("Dark")
                                    .tag($0)
                            }
                        }
                    } label: {
                        Label("Appearance", systemImage: "paintpalette")
                    }
                    
                    Picker(selection: $languageIdentifier){
                        Text("Device")
                            .tag("auto")
                        Text("English")
                            .tag("en")
                        Text("German")
                            .tag("de")
                        Text("French")
                            .tag("fr")
                    } label: {
                            Label("Game Language", systemImage: "translate")
//                            Text("Note: This will apply in the next round.")
//                                .font(.caption)
                    }
                    
                    Button("Edit Black List", systemImage: "long.text.page.and.pencil") { isShowingSheet = true }
                        .sheet(isPresented: $isShowingSheet, content: BlacklistView.init)
                    
                    Button("Delete All Data", systemImage: "trash", role: .destructive){
                        showAlert = true
                    }
                    .foregroundStyle(.red)
                        .alert("Do you want to delete all your data?", isPresented: $showAlert) {
                            Button("Delete", role: .destructive) {
                                gameState.stat = Statistic()
                                BlackList.list = []
                                do {
                                    try Statistic.save(gameState.stat)
                                } catch {
                                    fatalError("Couldn't save statistic")
                                }
                            }
                        } message: {
                            Text("Warning: This action is irreversible")
                        }
                    
                }
                
                Section {
                    DisclosureGroup {
                        AboutView()
                    } label: {
                        Label("About", systemImage: "info.circle")
                    }
                }
            }
            .foregroundStyle(.primary)
            .navigationTitle(LocalizedStringKey("Settings"))
        }
    }
}

