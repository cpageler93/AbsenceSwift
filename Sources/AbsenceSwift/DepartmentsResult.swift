//
//  DepartmentsResult.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 12.04.18.
//

import Foundation
import Quack


public extension Absence {
    
    public class DepartmentsResult: Quack.Model {
        
        public let data: [Department]?
        
        public required init?(json: JSON) {
            self.data = json.array?.compactMap { Department(json: $0) }
        }
        
    }
    
}
