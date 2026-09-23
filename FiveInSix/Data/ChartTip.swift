//
//  ChartTip.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 7/2/26.
//

import TipKit
import SwiftUI

struct ChartTip: Tip {
    var title: Text {
        Text("View how you performed")
    }
    
    var message: Text? {
        Text("The chart shows how often it took you how many tries to guess the word. The Y-axis shows the possible number of tries (1-6), while the X-axis shows how often you needed the corresponding number of tries. So, best case you see a big bar at \"1\" and a small bar at \"6\".")
    }
}
