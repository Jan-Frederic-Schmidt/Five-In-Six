//
//  BlacklistView.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/13/26.
//

import SwiftUI

struct BlacklistView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(BlackList.blacklist, id: \.self) { item in
                    Text(item.localizedCapitalized)
                }
                    .onDelete(perform: deleteItem)
            }
                .navigationTitle("Black List")
                .toolbar {
                    Button("Dismiss", systemImage: "xmark") {
                        print("The black list currently contains: \(BlackList.blacklist)")
                        dismiss()
                    }
                }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        BlackList.blacklist.remove(atOffsets: offsets)
    }
}

#Preview {
    BlacklistView()
}
