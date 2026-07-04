//
//  Extensions.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/10/2026.
//

import Foundation
import SwiftUI

extension Bundle{
    func chooseWord(for name: String, language: String, withLenght length: Int) async -> Set<String> {
        if let wordlistURL = Bundle.main.url(forResource: "\(name)-\(language).txt", withExtension: nil){
            if let wordlist = try? String(contentsOf: wordlistURL, encoding: .utf8) {
                    
                let allWords = wordlist.components(separatedBy: .newlines)
                    
                return Set(allWords.filter { $0.count == length && !$0.localizedStandardContains("ß")})
                    
                } else {
                    fatalError("Could not import list of words")
                }
            } else {
                fatalError("Could not find list of words")
            }
        }
}

extension Array<Character> {
    func convertToStrings() -> Array<String>{
        var newArray: Array<String> = []
        for i in self{
            newArray.append(String(i))
        }
        
        return newArray
    }
}

extension ShapeStyle where Self == Color{
    static var lightBackground: Color {
        Color(red: 0.969, green: 0.953, blue: 0.855)
    }
    
    static var darkBackground: Color {
        Color(red: 0.557, green: 0.471, blue: 0.341)
    }
}

func getStatistic() -> Statistic {
    if let data = UserDefaults.standard.object(forKey: "Statistic"){
        if let object = try? JSONDecoder().decode(Statistic.self, from: data as! Data){
            return object
        }
    }
    
    return Statistic()
}

