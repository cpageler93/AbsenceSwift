//
//  AbsencesResult.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation
import Quack
import SwiftyJSON


public class AbsencesResult: QuackModel {
    
    public let skip: Int
    public let limit: Int
    public let count: Int
    public let totalCount: Int
    public let data: [AbsenceEntry]
    
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
        self.data = dataArray.flatMap { AbsenceEntry(json: $0) }
    }

}
