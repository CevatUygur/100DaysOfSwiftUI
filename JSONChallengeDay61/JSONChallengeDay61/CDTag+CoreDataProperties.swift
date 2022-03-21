//
//  CDTag+CoreDataProperties.swift
//  JSONChallengeDay61
//
//  Created by CEVAT UYGUR on 21.03.2022.
//
//

import Foundation
import CoreData


extension CDTag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTag> {
        return NSFetchRequest<CDTag>(entityName: "CDTag")
    }

    @NSManaged public var name: String?
    @NSManaged public var tagOrigin: CDUser?

}

extension CDTag : Identifiable {

}
