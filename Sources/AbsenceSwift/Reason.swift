//
//  Reason.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 13.04.18.
//

import Foundation
import Quack


public extension Absence {
    
    public class Reason: Quack.Model {
        
        public let id: String
        public let name: String
        public let modified: Date
        
        public required init?(json: JSON) {
            guard let id = json["_id"].string,
                let name = json["name"].string,
                let modifiedString = json["modified"].string,
                let modified = DateFormatter.date(from: modifiedString)
            else {
                return nil
            }
            
            self.id = id
            self.name = name
            self.modified = modified
        }
        
    }
    
}
