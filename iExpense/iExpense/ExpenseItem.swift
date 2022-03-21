//
//  ExpenseItem.swift
//  iExpense
//
//  Created by CEVAT UYGUR on 8.03.2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
