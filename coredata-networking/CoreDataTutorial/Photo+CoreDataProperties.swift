//
//  Photo+CoreDataProperties.swift
//  CoreDataTutorial
//
//  Created by Moideen Nazaif VM on 04/06/19.
//  Copyright © 2019 James Rochabrun. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var author: String?
    @NSManaged public var mediaUrl: String?
    @NSManaged public var tags: String?

}
