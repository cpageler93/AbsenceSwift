//
//  AbsenceClientTests.swift
//  AbsenceSwiftTests
//
//  Created by Christoph Pageler on 22.11.17.
//

import XCTest
@testable import AbsenceSwift

class AbsenceClientTests: XCTestCase {
    
    func testAbsencesShouldReturnAValidResult() {
        
        let absence = AbsenceClient(id: "<your hawk id>", key: "<your hawk key>")
        let absences = absence.absences()
        switch absences {
        case .success(let absencesResult):
            XCTAssertGreaterThan(absencesResult.data.count, 0)
        case .failure:
            XCTFail("Failed to get absences")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
