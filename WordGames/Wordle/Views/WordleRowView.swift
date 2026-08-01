//
//  WordleFieldView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/22/26.
//

import Combine
import SwiftUI

struct WordleRowView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @AppStorage("showExclamationmarkWhenDifferentiateWithoutColor") var showExclamationmarkWhenDifferentiateWithoutColor = false
    
    @Binding var row: FieldRow
    @FocusState private var focusField: Int?
    @State var rotationAmount = Angle.degrees(0.0)
    
    let action: (FieldRow) -> Bool
    
    var body: some View {
        HStack{
            ForEach(0..<5){number in
                TextField("", text: $row.fields[number].guess)
                //text styling
                    .focused($focusField, equals: number)
                    .multilineTextAlignment(.center)
                    .font(.title).bold()
                    .textCase(.uppercase)
                    .autocorrectionDisabled()
                    .keyboardType(.asciiCapable)
                //frame styling
                    .frame(maxWidth: 100, maxHeight: 100)
                    .aspectRatio(1/1, contentMode: .fit)
                    .background (
                        RoundedRectangle(cornerRadius: 10)
                            .fill(row.fields[number].color)
                            .stroke(colorScheme == .light ? .darkBackground : .secondary)
                            .rotation3DEffect(rotationAmount, axis: (x: 0, y: 1, z: 0))
                    )
                    .overlay(alignment: .topTrailing) {
                        useWhenDifferentiateWithoutColor(number)
                            .font(.callout)
                            .accessibilityHidden(true)
                            .foregroundStyle(.white)
                            .padding(3)
                    }
                //executing code
                    .disabled(row.locked)
                    .onReceive(Just(row.fields[number].guess)){ _ in oneCharacter(input: &row.fields[number].guess) }
                    .onChange(of: row.fields[number].guess) { oldValue, newValue in
                        if focusField != nil {
                            if newValue.count >= 2 {
                                if focusField != 4 {
                                    row.fields[number + 1].guess = String(newValue.last!)
                                    focusField! += 1
                                }
                            } else if !oldValue.isEmpty && newValue.isEmpty {
                                if focusField != 0 {
                                    focusField! -= 1
                                }
                            }
                        }
                    }
                    .onSubmit {
                        if action(row) {
                            withAnimation(.bouncy(duration: 1)) {
                                rotationAmount += .degrees(180)
                            }
                        }
                    }
            }
        }
    }
    
    func oneCharacter (input: inout String){
        if input.count > 1{
            input = String(input.prefix(1))
        }
    }
    
    func useWhenDifferentiateWithoutColor(_ number: Int) -> Image {
        if differentiateWithoutColor {
            let color = row.fields[number].color
            if color == .green {
                return Image(systemName: "checkmark.circle.fill")
            } else if color == .orange {
                return Image(systemName: "arrow.left.and.right.circle.fill")
            } else if color == .gray && showExclamationmarkWhenDifferentiateWithoutColor {
                return Image(systemName: "exclamationmark.circle.fill")
            }
        }
        
        return Image(decorative: "")
    }
}


//#Preview {
//    WordleFieldView()
//}
