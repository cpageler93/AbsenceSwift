//
//  DateFormatter.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation


public extension Absence {
    
    class DateFormatter {
        
        static func date(from: String) -> Date? {
            let df = Foundation.DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return df.date(from: from)
        }
        
        static func string(from: Date) -> String {
            let df = Foundation.DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            return df.string(from: from)
        }
        
    }

}
