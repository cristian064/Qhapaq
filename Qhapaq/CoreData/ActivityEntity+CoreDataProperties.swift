//
//  ActivityEntity+CoreDataProperties.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 4/12/21.
//
//

import Foundation
import CoreData

extension ActivityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityEntity> {
        return NSFetchRequest<ActivityEntity>(entityName: "ActivityEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var distance: Double
    @NSManaged public var name: String?
    @NSManaged public var locations: NSSet?

}

// MARK: Generated accessors for locations
extension ActivityEntity {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: ActivityLocationEntity)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: ActivityLocationEntity)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

extension ActivityEntity: Identifiable {

}
