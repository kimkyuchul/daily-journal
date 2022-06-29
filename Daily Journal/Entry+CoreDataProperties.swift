//
//  Entry+CoreDataProperties.swift
//  Daily Journal
//
//  Created by qualson on 2022/04/22.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Entry : Identifiable {
    
    func month() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        if let dateToBeFormatter = date {
            let month = formatter.string(from: dateToBeFormatter)
            return month.uppercased()
        }
        return "ERR"
    }
    
    func day() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        if let dateToBeFormatter = date {
            let day = formatter.string(from: dateToBeFormatter)
            return day
        }
        return "ERR"
    }

}
