//
//  HabitItem.swift
//  HabitTracking
//
//  Created by CEVAT UYGUR on 14.03.2022.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
    var count: Int
}
