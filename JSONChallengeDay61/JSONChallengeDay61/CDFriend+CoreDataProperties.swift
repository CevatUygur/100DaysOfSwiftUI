//
//  CDFriend+CoreDataProperties.swift
//  JSONChallengeDay61
//
//  Created by CEVAT UYGUR on 21.03.2022.
//
//

import Foundation
import CoreData


extension CDFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDFriend> {
        return NSFetchRequest<CDFriend>(entityName: "CDFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var friendOrigin: CDUser?

}

extension CDFriend : Identifiable {

}
