//
//  UsersResult.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 13.04.18.
//

import Foundation
import Quack


public extension Absence {
    
    public class UsersResult: Quack.Model {
        
        public let data: [User]?
        
        public required init?(json: JSON) {
            self.data = json.array?.compactMap { User(json: $0) }
        }
        
    }
    
}
