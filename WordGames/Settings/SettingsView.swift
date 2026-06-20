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
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink {
                    GameRulesView()
                        .background(colorScheme == .light ? .lightBackground : .darkBackground)
                } label: {
                    Label("Game Rules", systemImage: "text.page")
                }
                
                Section{
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
                    
                    Button(role: .destructive){
                        showAlert = true
                    } label: {
                        Label("Delete All Data", systemImage: "trash")
                            .foregroundStyle(.red)
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
            .scrollContentBackground(.hidden)
            .background(colorScheme == .light ? .lightBackground : .darkBackground)
            .navigationTitle(LocalizedStringKey("Settings"))
            .alert("Do you want to delete all your data?", isPresented: $showAlert) {
                Button("Delete", role: .destructive) {
                    UserDefaults.standard.removeObject(forKey: "Statistic")
                    stat.statistic = getStatistic()
                }
            } message: {
                Text("Warning: This action is irreversible")
            }
        }
    }
}

