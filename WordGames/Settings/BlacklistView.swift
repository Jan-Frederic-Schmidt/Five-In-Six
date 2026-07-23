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
            Group {
                if BlackList.list.isEmpty {
                    ContentUnavailableView("No words in the black list", systemImage: "list.bullet.circle",description: Text("Blacklist a word by tapping \"Don't show again\" after a failed round."))
                } else {
                    List {
                        ForEach(BlackList.list, id: \.self) { item in
                            Text(item.localizedCapitalized)
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .navigationTitle("Black List")
                }
            }
            .toolbar {
                Button("Dismiss", systemImage: "xmark") {
                    dismiss()
                }
            }
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        BlackList.list.remove(atOffsets: offsets)
    }
}

#Preview {
    BlacklistView()
}
