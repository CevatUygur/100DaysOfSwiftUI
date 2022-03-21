//
//  CDUser+CoreDataProperties.swift
//  JSONChallengeDay61
//
//  Created by CEVAT UYGUR on 21.03.2022.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var age: Int16
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var registered: Date?
    @NSManaged public var avatar: Data?
    @NSManaged public var tag: CDTag?
    @NSManaged public var friend: CDFriend?

}

extension CDUser : Identifiable {

}
