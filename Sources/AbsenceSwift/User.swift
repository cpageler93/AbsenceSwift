//
//  User.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack


public extension Absence {
    
    public class User: Quack.Model {
        
        public let id: String
        public let created: Date
        public let modified: Date
        public let firstname: String
        public let lastname: String
        
        public required init?(json: JSON) {
            guard let id = json["_id"].string,
                let createdString = json["created"].string,
                let created = DateFormatter.date(from: createdString),
                let modifiedString = json["modified"].string,
                let modified = DateFormatter.date(from: modifiedString),
                let firstname = json["firstName"].string,
                let lastname = json["lastName"].string
            else {
                return nil
            }
            
            self.id = id
            self.created = created
            self.modified = modified
            self.firstname = firstname
            self.lastname = lastname
        }
        
    }
    
}
