//
//  UserTests.swift
//  AbsenceSwiftTests
//
//  Created by Christoph Pageler on 13.04.18.
//

import XCTest
@testable import AbsenceSwift

class UserTests: AbsenceSwiftTests {
    
    public static var allTests = [
        ("testUsersShouldReturnAllUsers", testUsersShouldReturnAllUsers)
    ]
    
    func testUsersShouldReturnAllUsers() {
        let (hawkId, hawkKey) = hawkAuth()
        let absence = Absence.Client(id: hawkId, key: hawkKey)
        let result = absence.users()
        switch result {
        case .success(let usersResult):
            XCTAssertGreaterThan(usersResult.count, 0)
            XCTAssertEqual(usersResult.count, usersResult.value?.data?.count ?? -1)
        case .failure:
            XCTFail()
        }
    }
    
    func testUsersWithLastnameFilterShouldReturnSingleUser() {
        let (hawkId, hawkKey) = hawkAuth()
        let absence = Absence.Client(id: hawkId, key: hawkKey)
        let options = Absence.Options.defaultOptions(withFilter: Absence.Filter(items: [
            Absence.Filter.Item.lastname("Pageler")
        ]))
        let result = absence.users(options: options)
        switch result {
        case .success(let usersResult):
            XCTAssertEqual(usersResult.count, 1)
            XCTAssertEqual(usersResult.count, usersResult.value?.data?.count ?? -1)
        case .failure:
            XCTFail()
        }
    }
    
}
