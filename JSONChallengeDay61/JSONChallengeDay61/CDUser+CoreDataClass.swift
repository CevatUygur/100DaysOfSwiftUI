//  CDUser+CoreDataClass.swift
//  JSONChallengeDay61
//  Created by CEVAT UYGUR on 21.03.2022.

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject, Decodable {
    
    // What properties to decode
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        // Attempt to extract the object
        guard let context = decoder.userInfo[.context!] as? NSManagedObjectContext else {
            fatalError("NSManagedObjectContext is missing")
        }
        
        // Actually create an instance of CDUser and tie it to the current managed object context
        self.init(context: context)
        
        // Decode JSON...
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(String.self, forKey: .id)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        name = try container.decode(String.self, forKey: .name)
        age = try container.decode(Int16.self, forKey: .age)
        company = try container.decode(String.self, forKey: .company)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(String.self, forKey: .address)
        
        let untrimmedAbout = try container.decode(String.self, forKey: .about)
        about = untrimmedAbout.trimmingCharacters(in: CharacterSet(charactersIn: "\r\n"))
        
        // Decode the date
        // SEE: https://developer.apple.com/documentation/foundation/dateformatter#overview
        // SEE: https://developer.apple.com/documentation/foundation/iso8601dateformatter
        // SEE: https://makclass.com/posts/24-a-quick-example-on-iso8601dateformatter-and-sorted-by-function
        let dateAsString = try container.decode(String.self, forKey: .registered)
        let dateFormatter = ISO8601DateFormatter()
        registered = dateFormatter.date(from: dateAsString) ?? Date()
        
        // Decode all the tags and tie to this entity
        let tagAsString = try container.decode([String].self, forKey: .tags)
        var tags: Set<CDTag> = Set()
        for tag in tagAsString {
            let newTag = CDTag(context: context)
            newTag.name = tag
            // Associate each tag in the set with this user
            newTag.tagOrigin = self
            tags.insert(newTag)
        }
        //tag = tags as NSSet
        
        // Decode all the friends and tie to this entity
        //let friends = try container.decode(Set<CDFriend>.self, forKey: .friends)
        //for friend in friends {
            // Associate each friend in the set with this user
           // friend.friendOrigin = self
        //}
        //friend = friends as NSSet
        
    }

}
