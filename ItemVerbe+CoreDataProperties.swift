//
//  ItemVerbe+CoreDataProperties.swift
//  French Verbs Quiz
//
//  Created by Normand Martin on 2016-12-11.
//  Copyright © 2016 Normand Martin. All rights reserved.
//

import Foundation
import CoreData


extension ItemVerbe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemVerbe> {
        return NSFetchRequest<ItemVerbe>(entityName: "ItemVerbe");
    }

    @NSManaged public var bonneReponse: Int32
    @NSManaged public var mauvaiseReponse: Int32
    @NSManaged public var tempsVerbe: String?
    @NSManaged public var verbeInfinitif: String?
    @NSManaged public var modeVerbe: String?
    @NSManaged public var bonneReponseTemps: Int32
    @NSManaged public var mauvaiseReposeTemps: Int32

}
