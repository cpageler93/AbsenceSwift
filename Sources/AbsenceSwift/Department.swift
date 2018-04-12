//
//  Department.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 12.04.18.
//

import Foundation
import Quack


public extension Absence {
    
    public class Department: Quack.Model {
        
        public let id: String
        public let company: String
        public let name: String
        
        public required init?(json: JSON) {
            guard let id = json["id"].string,
                let company = json["company"].string,
                let name = json["name"].string
            else {
                return nil
            }
        
            self.id = id
            self.company = company
            self.name = name
        }
    }
    
}
