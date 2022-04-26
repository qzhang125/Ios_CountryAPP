//
//  FAVOURITE+CoreDataProperties.swift
//  FinalTest_Qiuyu
//
//  Created by Qiuyu Zhang on 2022-04-15.
//
//

import Foundation
import CoreData


extension FAVOURITE {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FAVOURITE> {
        return NSFetchRequest<FAVOURITE>(entityName: "FAVOURITE")
    }

    @NSManaged public var name: String?
    @NSManaged public var population: Int64

}

extension FAVOURITE : Identifiable {

}
