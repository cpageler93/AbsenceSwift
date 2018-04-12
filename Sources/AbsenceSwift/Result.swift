//
//  Result.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack


public extension Absence {
    
    public class Result<AbsenceModel: Quack.Model>: Quack.Model {
        
        public let skip: Int
        public let limit: Int
        public let count: Int
        public let totalCount: Int
        public let value: AbsenceModel?
        
        public required init?(json: JSON) {
            guard let skip = json["skip"].int,
                let limit = json["limit"].int,
                let count = json["count"].int,
                let totalCount = json["totalCount"].int
            else {
                return nil
            }
            
            self.skip = skip
            self.limit = limit
            self.count = count
            self.totalCount = totalCount
            self.value = AbsenceModel(json: json["data"])
        }
        
    }

}
