//
//  WordGamesApp.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/23/26.
//
import SwiftUI

@main
struct WordleApp: App {
    @AppStorage("colorScheme") var storedColorScheme = 0
    @AppStorage("languageIdentifier") var languageIdentifier = "auto"
    
    var colorScheme: ColorScheme? {
        switch storedColorScheme{
        case 0:
            return nil
        case 1:
            return .light
        default:
            return .dark
        }
    }
    
    var currentLocale: Locale {
        if languageIdentifier == "auto"{
            return Locale.current
        } else {
            return Locale(identifier: languageIdentifier)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(colorScheme)
                .environment(\.locale, currentLocale)
        }
    }
}
