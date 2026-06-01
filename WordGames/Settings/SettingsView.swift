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
    
    var body: some View {
        NavigationStack{
            Form{
                NavigationLink{
                    GameRulesView()
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
                        Label("Choose a Color Scheme", systemImage: "paintpalette")
                    }
                    
                    Picker(selection: $languageIdentifier){
                        Text("Device")
                            .tag("auto")
                        Text("Deutsch")
                            .tag("de")
                        Text("English")
                            .tag("en")
                        Text("Français")
                            .tag("fr")
                    } label: {
                        Label("Choose a Language", systemImage: "translate")
                    }
                    
                    Button(role: .destructive){
                        UserDefaults.standard.removeObject(forKey: "Statistic")
                        stat.statistic = getStatistic()
                    } label: {
                        Label("Delete All Data", systemImage: "trash")
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    NavigationLink {
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

