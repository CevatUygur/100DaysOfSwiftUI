//
//  JSONDecoder.swift
//  JSONChallengeDay61
//
//  Created by CEVAT UYGUR on 21.03.2022.
//

import CoreData
import Foundation

// See: https://stackoverflow.com/a/52698618
// See: https://www.donnywals.com/using-codable-with-core-data-and-nsmanagedobject/
// Required to decode straight from JSON into Core Data managed objects
extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}

extension JSONDecoder {
    convenience init(context: NSManagedObjectContext) {
        self.init()
        self.userInfo[.context!] = context
    }
}
