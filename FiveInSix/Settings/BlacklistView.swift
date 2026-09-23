//
//  BlacklistView.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/13/26.
//

import SwiftUI

struct BlacklistView: View {
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            Group {
                if BlackList.general.list.isEmpty {
                    ContentUnavailableView("No words in the black list", systemImage: "list.bullet.circle",description: Text("Blacklist a word by tapping \"Don't show again\" after a failed round."))
                } else {
                    List {
                        ForEach(BlackList.general.list.sorted(), id: \.self) { word in
                            if word.contains(searchText.uppercased()) || searchText.isEmpty{
                                Text(word.localizedCapitalized)
                            }
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .navigationTitle("Black List")
                    .searchable(text: $searchText, placement: .toolbarPrincipal)
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
        BlackList.general.list.remove(atOffsets: offsets)
    }
}

#Preview {
    BlacklistView()
}
