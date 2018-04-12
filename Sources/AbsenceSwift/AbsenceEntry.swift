//
//  AbsenceEntry.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack


public extension Absence {
    
    public class AbsenceEntry: Quack.Model {
        
        public let id: String
        public let start: Date
        public let end: Date
        public let created: Date
        public let modified: Date
        public let assignedTo: User?
        public let approver: User?
        
        public required init?(json: JSON) {
            guard let id = json["_id"].string,
                let startString = json["start"].string,
                let start = DateFormatter.date(from: startString),
                let endString = json["end"].string,
                let end = DateFormatter.date(from: endString),
                let createdString = json["created"].string,
                let created = DateFormatter.date(from: createdString),
                let modifiedString = json["modified"].string,
                let modified = DateFormatter.date(from: modifiedString)
            else {
                return nil
            }
            
            self.id = id
            self.start = start
            self.end = end
            self.created = created
            self.modified = modified
            self.assignedTo = User(json: json["assignedTo"])
            self.approver = User(json: json["approver"])
        }
        
    }

}
