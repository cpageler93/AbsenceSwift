//
//  AbsenceClientTests.swift
//  AbsenceSwiftTests
//
//  Created by Christoph Pageler on 22.11.17.
//

import XCTest
@testable import AbsenceSwift

class AbsenceClientTests: XCTestCase {
    
    private func hawkAuth() -> (String, String) {
        guard let hawkId = ProcessInfo.processInfo.environment["hawkId"] else {
            fatalError()
        }
        guard let hawkKey = ProcessInfo.processInfo.environment["hawkKey"] else {
            fatalError()
        }
        return (hawkId, hawkKey)
    }
    
    func testAbsencesShouldReturnAValidResult() {
        let (hawkId, hawkKey) = hawkAuth()
        
        let absence = AbsenceClient(id: hawkId, key: hawkKey)
        let absences = absence.absences()
        switch absences {
        case .success(let absencesResult):
            XCTAssertGreaterThan(absencesResult.data.count, 0)
        case .failure:
            XCTFail("Failed to get absences")
        }
        
    }
    
}
