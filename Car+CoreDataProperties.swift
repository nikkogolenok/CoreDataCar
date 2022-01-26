//
//  Car+CoreDataProperties.swift
//  CoreDataCar
//
//  Created by Никита Коголенок on 26.01.22.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var mark: String?
    @NSManaged public var model: String?
    @NSManaged public var rating: Double
    @NSManaged public var timesDriven: Int16
    @NSManaged public var lastStarted: Date?
    @NSManaged public var myChoice: Bool
    @NSManaged public var imageData: Data?
    @NSManaged public var tintColor: NSObject?

}

extension Car : Identifiable {

}
