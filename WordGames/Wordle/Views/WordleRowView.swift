//
//  WordleFieldView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/22/26.
//

import Combine
import SwiftUI

struct WordleRowView: View {
    
    @Binding var row: FieldRow
    @FocusState private var focusField: Int?
    
    let action: () -> Void
    
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
                    .frame(maxWidth: 80, maxHeight: 80)
                    .aspectRatio(1/1, contentMode: .fit)
                    .glassEffect(.regular.tint(row.fields[number].color).interactive(), in: .rect(cornerRadius: 15))
                //executing code
                    .disabled(row.locked)
                    .onReceive(Just(row.fields[number].guess)){ _ in oneCharacter(input: &row.fields[number].guess) }
                    .disabled(row.locked)
                    .onChange(of: row.fields[number].guess) { _, newValue in
                        if !newValue.isEmpty {
                            if focusField != nil {
                                if focusField != 4 {
                                    focusField! += 1
                                }
                            }
                        }
                    }
                    .onSubmit(action)
            }
        }
    }
    
    func oneCharacter (input: inout String){
        if input.count > 1{
            input = String(input.prefix(1))
        }
    }
}

//#Preview {
//    WordleFieldView()
//}
