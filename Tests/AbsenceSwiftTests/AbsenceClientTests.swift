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
        
        let absence = Absence.Client(id: hawkId, key: hawkKey)
        
        let date = Absence.DateFormatter.date(from: "2017-11-22T00:00:00.000Z") ?? Date()
        let filterItems = [
            Absence.Filter.Item.start(.lte(date)),
            Absence.Filter.Item.end(.gte(date))
        ]
        let options = Absence.Options(skip: 0, limit: 50, filter: Absence.Filter(items: filterItems))
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
        
        let absence = Absence.Client(id: hawkId, key: hawkKey)
        
        let filterItems = [
            Absence.Filter.Item.assignedTo(.email("cp@thepeaklab.com"))
        ]
        let options = Absence.Options(skip: 0, limit: 50, filter: Absence.Filter(items: filterItems))
        let absences = absence.absences(options: options)
        switch absences {
        case .success(let absencesResult):
            XCTAssertGreaterThan(absencesResult.data.count, 0)
        case .failure:
            XCTFail("Failed to get absences")
        }
        
    }
    
}
