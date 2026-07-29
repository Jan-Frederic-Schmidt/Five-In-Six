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
        VStack {
            TimeSelectorWheel(selection: $internalTime)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    TimeSelectorRecommendations(times: times, externalTime: $internalTime)
                }
                .padding(.horizontal)
            }
        }
        
        Button("START!") {
            maxTime = internalTime
            useTimer = true
            dismiss()
        }
        .font(.largeTitle)
        .fontWeight(.black)
        .foregroundStyle(.white)
        .buttonStyle(.borderedProminent).tint(.red)
        .padding()
    }
}

struct TimeSelectorWheel: View {
    @Binding var selection: Int
    
    var body: some View {
        Picker("Choose a duration", selection: $selection) {
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
}

struct TimeSelectorRecommendations: View {
    let times: Array<Int>
    @Binding var externalTime: Int
    
    var body: some View {
        ForEach(times, id: \.self) { selectedTime in
                Button("^[\(selectedTime) minute](inflect: true)") {
                    externalTime = selectedTime * 60
                }
                .font(.title3.bold())
                .padding(.vertical, 5)
                .buttonStyle(.bordered)
                .foregroundStyle(.primary)
            }
    }
}
