//
//  Location.swift
//  BucketList
//
//  Created by CEVAT UYGUR on 1.04.2022.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
