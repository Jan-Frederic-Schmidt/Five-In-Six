//
//  ShareTip.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 7/2/26.
//

import TipKit
import SwiftUI

struct ShareTip: Tip {
    var title: Text {
        Text("Share current word with others")
    }
    
    var message: Text? {
        Text("Share the word you're currently playing as short code for others to try guessing the same word.")
    }
}
