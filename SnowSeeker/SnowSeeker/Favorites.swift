//
//  Favorites.swift
//  SnowSeeker
//
//  Created by CEVAT UYGUR on 21.04.2022.
//

import Foundation
import SwiftUI

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        //load out saved data
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        //
        
    }
}
