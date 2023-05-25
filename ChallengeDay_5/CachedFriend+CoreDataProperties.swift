//
//  CachedFriend+CoreDataProperties.swift
//  ChallengeDay_5
//
//  Created by Mateusz Ratajczak on 25/05/2023.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CachedUser?
    
    public var wrappedID: String {
        id ?? "Unknown"
    }
    
    public var wrappedName: String {
        name ?? "Unknown"
    }

}

extension CachedFriend : Identifiable {

}
