//
//  AbsencesOptions.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 25.11.17.
//

import Foundation

public class AbsencesOptions {
    
    let skip: Int
    let limit: Int
    let filter: AbsencesFilter?
    
    public init(skip: Int, limit: Int, filter: AbsencesFilter? = nil) {
        self.skip = skip
        self.limit = limit
        self.filter = filter
    }
    
    public static func defaultOptions() -> AbsencesOptions {
        return AbsencesOptions(skip: 0, limit: 50)
    }
    
}
