//
//  Options.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 25.11.17.
//

import Foundation


public extension Absence {
    
    public class Options {
        
        let skip: Int
        let limit: Int
        let filter: Filter?
        
        public init(skip: Int, limit: Int, filter: Filter? = nil) {
            self.skip = skip
            self.limit = limit
            self.filter = filter
        }
        
        public static func defaultOptions(withFilter filter: Filter) -> Options {
            return Options(skip: 0, limit: 50, filter: filter)
        }
        
        public static func defaultOptions() -> Options {
            return Options(skip: 0, limit: 50)
        }
        
    }

}
