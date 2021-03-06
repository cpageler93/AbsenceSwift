//
//  AbsencesResult.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 12.04.18.
//

import Foundation
import Quack


public extension Absence {
    
    public class AbsencesResult: Quack.Model {
        
        public let data: [AbsenceEntry]?
        
        public required init?(json: JSON) {
            self.data = json.array?.compactMap { AbsenceEntry(json: $0) }
        }

    }
    
}
