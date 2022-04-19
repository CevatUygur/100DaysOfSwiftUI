//
//  DataManager.swift
//  Flashzilla
//
//  Created by CEVAT UYGUR on 19.04.2022.
//

import Foundation

struct DataManeger {
    static let savePath = FileManager.documentsDirectory.appendingPathComponent("SaveData")
    
    static func load() -> [Card] {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                return decoded
            }
        }
        
        return []
    }
    
    static func save(_ cards: [Card]) {
        if let data = try? JSONEncoder().encode(cards) {
            try? data.write(to: savePath, options: [.atomic, .completeFileProtection])
        }
    }
}
