//
//  ActivityEntity+CoreDataProperties.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 7/11/21.
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

}

extension ActivityEntity : Identifiable {

}
