//
//  BlackList.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/13/26.
//

import Foundation

struct BlackList: Codable {
    static var blacklist = getBlacklist() {
        didSet {
            do {
                let encoded = try JSONEncoder().encode(blacklist)
                UserDefaults.standard.set(encoded, forKey: "blacklist")
            } catch {
                print("Couldn't save blacklist")
            }
        }
    }
    
    static private func getBlacklist() -> [String] {
        do {
            if let encoded = UserDefaults.standard.data(forKey: "blacklist") {
                return try JSONDecoder().decode([String].self, from: encoded)
            }
        } catch {
            print("Couldn't decode blacklist")
        }
        
        return [String]()
    }
}
