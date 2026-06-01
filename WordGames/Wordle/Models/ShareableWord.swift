//
//  ShareableWord.swift
//  WordGames
//
//  Created by Jan Schmidt on 6/1/26.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct ShareableWord: Codable, Transferable {
    let word: String
    let guesses: Array<String>
    let guessCount: Int
    
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .json)
    }
}
