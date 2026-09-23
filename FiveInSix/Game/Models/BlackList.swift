//
//  BlackList.swift
//  WordGames
//
//  Created by Jan Schmidt on 7/13/26.
//

import Foundation

@Observable
class BlackList: Codable {
    var list: Array<String> {
        didSet {
            do {
                let encoded = try JSONEncoder().encode(list)
                UserDefaults.standard.set(encoded, forKey: "blacklist")
            } catch {
                print("Couldn't save blacklist")
            }
        }
    }
    
    static var general = BlackList()
    
    init() {
        do {
            if let encoded = UserDefaults.standard.data(forKey: "blacklist") {
                self.list = try JSONDecoder().decode([String].self, from: encoded)
            }
        } catch {
            print("Couldn't decode blacklist")
        }
        
        self.list = []
    }
}
