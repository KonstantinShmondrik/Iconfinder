//
//  LocalQueryRequest+CoreDataProperties.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 11.08.2024.
//
//

import Foundation
import CoreData


extension LocalQueryRequest {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalQueryRequest> {
        return NSFetchRequest<LocalQueryRequest>(entityName: "LocalQueryRequest")
    }

    @NSManaged public var query: String?
    @NSManaged public var icons: NSSet?

}

// MARK: Generated accessors for icons
extension LocalQueryRequest {

    @objc(addIconsObject:)
    @NSManaged public func addToIcons(_ value: LocalIcon)

    @objc(removeIconsObject:)
    @NSManaged public func removeFromIcons(_ value: LocalIcon)

    @objc(addIcons:)
    @NSManaged public func addToIcons(_ values: NSSet)

    @objc(removeIcons:)
    @NSManaged public func removeFromIcons(_ values: NSSet)

}

extension LocalQueryRequest : Identifiable {

}
