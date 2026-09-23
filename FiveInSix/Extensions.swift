//
//  Extensions.swift
//  WordGames © 2026 by Jan Frédéric Schmidt is licensed under CC BY-NC-ND 4.0
//
//  Created by Jan Schmidt on 4/10/2026.
//

import Foundation
import SwiftUI

extension Array<Character> {
    func convertToString() -> Array<String>{
        var newArray: Array<String> = []
        for i in self{
            newArray.append(String(i))
        }
        
        return newArray
    }
}

extension View {
    func systemSpecificBackground(_ color: Color?, in shape: some Shape = .rect, liquidGlassIsInteractive: Bool = false) -> some View {
        if #available(iOS 26.0, *) {
            return self.glassEffect(.regular.interactive(liquidGlassIsInteractive).tint(color), in: shape)
        } else {
            return self.background(color ?? .secondary, in: shape)
        }
    }
}

extension ShapeStyle where Self == Color{
    static var lightBackground: Color {
        Color(red: 0.949, green: 0.949, blue: 0.949)
    }
    
    static var darkBackground: Color {
        Color(red: 0.000, green: 0.000, blue: 0.000)
    }
}

// Made with AI 
extension Data {
    init?(hexString: String) {
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i * 2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
}

