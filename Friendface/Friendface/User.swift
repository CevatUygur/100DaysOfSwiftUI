//
//  User.swift
//  Friendface
//
//  Created by CEVAT UYGUR on 19.04.2022.
//

import Foundation

struct User: Identifiable, Codable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    static let example = User(id: UUID(), isActive: true, name: "Cevat Uygur", age: 33, company: "Freelancer", email: "cevatuygur@gmail.com", address: "Turkey", about: "IOS Developer", registered: Date.now, tags: ["swift", "swiftui"], friends: [])
}
