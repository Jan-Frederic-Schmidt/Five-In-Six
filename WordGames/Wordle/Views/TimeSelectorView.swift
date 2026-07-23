//
//  TimeSelectorView.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/9/26.
//

import SwiftUI

struct TimeSelectorView: View {
    @Environment(\.dismiss) var dismiss
    let times = [1, 2, 5, 10]
    @State private var internalTime = 60
    @Binding var maxTime: Int
    @Binding var useTimer: Bool
    
    var body: some View {
        HStack {
            VStack {
                ForEach(times, id: \.self) { selectedTime in
                    HStack {
                        Button {
                            internalTime = selectedTime * 60
                        } label: {
                            Text("^[\(selectedTime) minute](inflect: true)")
                                .font(.title3.bold())
                                .padding(.vertical, 5)
                            
                            Spacer()
                        }
                        .buttonStyle(.plain)
                        
                        Spacer()
                    }
                    .padding(10)
                    .background(.secondary, in: .capsule)
                }
            }
            .padding()
            
            Picker("Choose a duration", selection: $internalTime) {
                ForEach(1..<21) { number in
                    Text("^[\(number) minute](inflect: true)")
                        .tag(number * 60)
                }
            }
            .pickerStyle(.wheel)
            .font(.title3)
            .labelsHidden()
            .padding()
            .background(.secondary, in: .rect(cornerRadius: 25))
            .padding()
        }
        
        Button("START!") {
            maxTime = internalTime
            useTimer = true
            dismiss()
        }
        .font(.largeTitle)
        .fontWeight(.black)
        .foregroundStyle(.white)
        .padding(.horizontal, 50)
        .buttonStyle(.borderedProminent).tint(.red)
        .padding()
    }
}
