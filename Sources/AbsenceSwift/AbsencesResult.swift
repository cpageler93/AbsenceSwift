//
//  AbsencesResult.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack
import SwiftyJSON


public extension Absence {
    
    public class Result: QuackModel {
        
        public let skip: Int
        public let limit: Int
        public let count: Int
        public let totalCount: Int
        public let data: [Entry]
        
        public required init?(json: JSON) {
            guard
                let skip = json["skip"].int,
                let limit = json["limit"].int,
                let count = json["count"].int,
                let totalCount = json["totalCount"].int,
                let dataArray = json["data"].array
                else {
                    return nil
            }
            
            self.skip = skip
            self.limit = limit
            self.count = count
            self.totalCount = totalCount
            self.data = dataArray.flatMap { Entry(json: $0) }
        }
        
    }

}
