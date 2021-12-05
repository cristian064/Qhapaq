//
//  ActivityLocationEntity+CoreDataProperties.swift
//  Qhapaq
//
//  Created by Cristian Ayala Laura on 4/12/21.
//
//

import Foundation
import CoreData


extension ActivityLocationEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ActivityLocationEntity> {
        return NSFetchRequest<ActivityLocationEntity>(entityName: "ActivityLocationEntity")
    }

    @NSManaged public var longitude: Double
    @NSManaged public var latitude: Double
    @NSManaged public var activity: ActivityEntity?

}

extension ActivityLocationEntity : Identifiable {

}
