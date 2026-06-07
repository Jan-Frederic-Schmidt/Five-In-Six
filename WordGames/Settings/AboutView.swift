//
//  AboutView.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 5/14/26.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("About")
                    .font(.title).bold()
                Text("WordGames is a shared-source hobby project, and isn't affiliated with Josh Wardle or the New York Times at all. All source code can be found at https://github.com/Jan-Frederic-Schmidt/WordGames  \n\nWordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0")
            }
        }
    }
}

#Preview {
    AboutView()
}
