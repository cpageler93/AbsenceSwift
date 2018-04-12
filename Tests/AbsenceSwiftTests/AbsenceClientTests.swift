//
//  AbsenceClientTests.swift
//  AbsenceSwiftTests
//
//  Created by Christoph Pageler on 22.11.17.
//

import XCTest
@testable import AbsenceSwift

class AbsenceSwiftTests: XCTestCase {
    
    internal func hawkAuth() -> (String, String) {
        guard let hawkId = ProcessInfo.processInfo.environment["hawkId"] else {
            fatalError()
        }
        guard let hawkKey = ProcessInfo.processInfo.environment["hawkKey"] else {
            fatalError()
        }
        return (hawkId, hawkKey)
    }
    
}
