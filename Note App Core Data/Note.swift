//
//  Note.swift
//  Note App Core Data
//
//

import CoreData

@objc(Note)
class Note : NSManagedObject {
    @NSManaged var id : NSNumber!
    @NSManaged var title : String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
