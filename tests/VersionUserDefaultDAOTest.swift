//
//  VersionDAOUserDefaultTest.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import XCTest

class VersionUserDefaultDAOTest: XCTestCase {
    var dao: VersionUserDefaultDAO!
    
    private typealias SelectedVersion = [String: Float]
    private typealias SelectedTests = [String: SelectedVersion]
    private let storageName = "GollumSelectedTests"
    
    // MARK: - XCTestCase
    
    override func setUp() {
        dao = VersionUserDefaultDAO()
    }
    
    override func tearDown() {
        removeSelectedTest()
    }
    
    // MARK: - Tests
    
    func testSaveSelectedVersion() {
        let testName = "MySuperTest"
        let version = Version(name: "A", probability: 0.2)
        
        dao.saveSelectedVersion(version, testName: testName)
        
        let selectedTests = loadSelectedTests()
        XCTAssertNotNil(selectedTests)
        XCTAssertEqual(selectedTests?.keys.first, testName)
        XCTAssertEqual(selectedTests?[testName]?.keys.first, version.name)
        XCTAssertEqual(selectedTests?[testName]?[version.name], version.probability)
    }
    
    // MARK: - Private
    
    private func loadSelectedTests() -> SelectedTests? {
        return NSUserDefaults.standardUserDefaults().objectForKey(storageName) as? SelectedTests
    }
    
    private func removeSelectedTest() {
        NSUserDefaults.standardUserDefaults().removeObjectForKey(storageName)
    }
}
