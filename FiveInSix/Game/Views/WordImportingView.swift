//
//  WordImportingView.swift
//  WordGames
//
//  Created by Jan Schmidt on 8/1/26.
//

import SwiftUI

struct WordImportingView: View {
    @State private var code = ""
    @Environment(GameState.self) var gameState
    @Environment(\.dismiss) var dismiss
    var functionResult: (isReal: Bool, word: String?) {
        checkIfImportIsRealWord()
    }
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                TextField("Enter the code", text: $code)
                    .frame(maxWidth: .infinity)
                    .font(.title3)
                    .padding()
                    .glassEffect(.regular, in: .capsule)
                
                Button {
                    switch functionResult.isReal {
                    case true:
                        if let string = functionResult.word {
                            gameState.importWord(string)
                            dismiss()
                        }
                    case false:
                        dismiss()
                    }
                } label: {
                    Image(systemName: functionResult.isReal ? "checkmark" : "xmark")
                        .foregroundStyle(.white)
                        .font(.title3)
                        .padding()
                        .glassEffect(.regular.tint(functionResult.isReal ? .green : .red), in: .circle)
                        .contentTransition(
                            .symbolEffect(.replace)
                        )
                }
                .accessibilityHint(functionResult.isReal ? "Start playing!" : "Exit")
            }
        }
        .padding()
        .frame(height: 200)
    }
    
    func checkIfImportIsRealWord() -> (isReal: Bool, word: String?) {
        if let data = Data(hexString: code) {
            if let importedString = String(data: data, encoding: .utf8) {
                if gameState.wordList.list.contains(importedString) {
                        return (isReal: true, word: importedString)
                }
            }
        }
        
        return (isReal: false, word: nil)
    }
}
