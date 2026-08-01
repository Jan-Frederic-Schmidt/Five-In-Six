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
                
                Image(systemName: functionResult.isReal ? "checkmark" : "xmark")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding()
                    .glassEffect(.regular.tint(functionResult.isReal ? .green : .red), in: .circle)
                    .contentTransition(
                        .symbolEffect(.replace)
                    )
            }
            
            
            Button("START!") {
                if let string = functionResult.word {
                    gameState.importWord(string)
                    dismiss()
                }
            }
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundStyle(.white)
            .padding()
            .glassEffect(.regular.tint(.red).interactive(), in: .capsule)
            .disabled(!functionResult.isReal)
        }
        .padding()
        .frame(height: 250)
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
