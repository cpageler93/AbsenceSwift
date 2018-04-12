//
//  DepartmentTests.swift
//  AbsenceSwiftTests
//
//  Created by Christoph Pageler on 12.04.18.
//

import XCTest
@testable import AbsenceSwift

class DepartmentTests: AbsenceSwiftTests {
    
    public static var allTests = [
        ("testDepartmentsShouldReturnAllDepartments", testDepartmentsShouldReturnAllDepartments)
    ]

    func testDepartmentsShouldReturnAllDepartments() {
        let (hawkId, hawkKey) = hawkAuth()
        let absence = Absence.Client(id: hawkId, key: hawkKey)
        let result = absence.departments()
        switch result {
        case .success(let departmentsResult):
            XCTAssertGreaterThan(departmentsResult.count, 0)
            XCTAssertEqual(departmentsResult.count, departmentsResult.value?.data?.count ?? -1)
        case .failure:
            XCTFail()
        }
    }
    
}
