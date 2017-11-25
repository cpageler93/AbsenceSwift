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
    
    func testAbsencesForDateShouldReturnAValidResult() {
        let (hawkId, hawkKey) = hawkAuth()
        
        let absence = AbsenceClient(id: hawkId, key: hawkKey)
        
        let date = AbsenceDateFormatter.date(from: "2017-11-22T00:00:00.000Z") ?? Date()
        let filterItems = [
            AbsencesFilter.Item.start(.lte(date)),
            AbsencesFilter.Item.end(.gte(date))
        ]
        let options = AbsencesOptions(skip: 0, limit: 50, filter: AbsencesFilter(items: filterItems))
        let absences = absence.absences(options: options)
        switch absences {
        case .success(let absencesResult):
            XCTAssertGreaterThan(absencesResult.data.count, 0)
        case .failure:
            XCTFail("Failed to get absences")
        }
        
    }
    
    func testAbsencesForUserShouldReturnAValidResult() {
        let (hawkId, hawkKey) = hawkAuth()
        
        let absence = AbsenceClient(id: hawkId, key: hawkKey)
        
        let filterItems = [
            AbsencesFilter.Item.assignedTo(.email("cp@thepeaklab.com"))
        ]
        let options = AbsencesOptions(skip: 0, limit: 50, filter: AbsencesFilter(items: filterItems))
        let absences = absence.absences(options: options)
        switch absences {
        case .success(let absencesResult):
            XCTAssertGreaterThan(absencesResult.data.count, 0)
        case .failure:
            XCTFail("Failed to get absences")
        }
        
    }
    
}
