//
//  AbsenceDateFormatter.swift
//  AbsenceSwift
//
//  Created by Christoph Pageler on 22.11.17.
//

import Foundation

class AbsenceDateFormatter {
    
    static func date(from: String) -> Date? {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return df.date(from: from)
    }
    
}
