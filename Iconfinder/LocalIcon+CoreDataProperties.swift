//
//  LocalIcon+CoreDataProperties.swift
//  Iconfinder
//
//  Created by Константин Шмондрик on 11.08.2024.
//
//

import Foundation
import CoreData


extension LocalIcon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalIcon> {
        return NSFetchRequest<LocalIcon>(entityName: "LocalIcon")
    }

    @NSManaged public var iconID: Int32
    @NSManaged public var tags: String?
    @NSManaged public var sizes: String?
    @NSManaged public var previewURL: String?
    @NSManaged public var downloadURL: String?
    @NSManaged public var icon: LocalQueryRequest?

}

extension LocalIcon : Identifiable {

}
