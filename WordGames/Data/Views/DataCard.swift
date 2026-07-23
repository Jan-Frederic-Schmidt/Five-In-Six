//
//  DataCard.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/23/26.
//

import SwiftUI

struct DataCard: View {
    struct clearDivider: View {
        var body: some View {
            Rectangle()
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 2)
        }
    }
    
    let data: LocalizedStringKey
    let description: LocalizedStringKey
    let color: Color
    let aspectRatio: CGFloat?
    let height: CGFloat?
    
    var body: some View {
        VStack {
            Text(data)
                .font(.largeTitle)
                .fontWeight(.heavy)
            clearDivider()
            Text(description)
        }
        .foregroundStyle(.white)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: height)
        .aspectRatio(aspectRatio, contentMode: .fit)
        .background(color)
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 5)
    }
}
