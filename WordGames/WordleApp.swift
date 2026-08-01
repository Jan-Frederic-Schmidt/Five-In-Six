//
//  WordGamesApp.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/23/26.
//

import SwiftUI
import TipKit

@main
struct WordleApp: App {
    @AppStorage("colorScheme") var storedColorScheme = 0
    @AppStorage("useSerifs") var useSerifs = true
    
    var colorScheme: ColorScheme? {
        switch storedColorScheme {
        case 0:
            return nil
        case 1:
            return .light
        default:
            return .dark
        }
    }
    
    @State private var gameState = GameState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorScheme)
                .fontDesign(useSerifs ? .serif : .default)
                .dynamicTypeSize(...DynamicTypeSize.accessibility2)
        }
        .environment(gameState)
    }
    
    init() {
        do {
            try Tips.configure()
        } catch {
            print("Error: Unable to configure tips - \(error.localizedDescription)")
        }
    }
}
