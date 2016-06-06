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
    
    // MARK: - XCTestCase
    
    override func setUp() {
        dao = VersionUserDefaultDAO()
    }
    
    override func tearDown() {
        removeSelectedTestsFromStorage()
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

    func testDidSelectVersionForTestReturningTrue() {
        let testName = "AmazingTest"
        let version = Version(name: "B", probability: 0.4)
        
        dao.saveSelectedVersion(version, testName: testName)
        
        XCTAssertTrue(dao.didSelectVersionForTest(testName))
    }

    func testDidSelectVersionForTestReturningFalse() {
        let testName = "AmazingTest2"
        XCTAssertFalse(dao.didSelectVersionForTest(testName))
    }
    
    func testLoadSelectedVersions() {
        let test1Name = "AnotherSuperTest1"
        let versionTest1 = Version(name: "A", probability: 0.9)
        
        let test2Name = "AnotherSuperTest2"
        let versionTest2 = Version(name: "X", probability: 0.1)
        
        dao.saveSelectedVersion(versionTest1, testName: test1Name)
        dao.saveSelectedVersion(versionTest2, testName: test2Name)
        
        var selectedVersions: [String: Version]?
        do {
            selectedVersions = try dao.loadSelectedVersions()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(selectedVersions?.keys.count, 2)
        XCTAssertEqual(selectedVersions?[test1Name]?.name, versionTest1.name)
        XCTAssertEqual(selectedVersions?[test1Name]?.probability, versionTest1.probability)
        XCTAssertEqual(selectedVersions?[test2Name]?.name, versionTest2.name)
        XCTAssertEqual(selectedVersions?[test2Name]?.probability, versionTest2.probability)
    }
    
    func testLoadSelectedVersionsLoadingFromUserDefault() {
        let testName = "AnotherHiperTest1"
        let versionTest = Version(name: "E", probability: 0.8)
        
        dao.saveSelectedVersion(versionTest, testName: testName)
        
        var selectedVersions: [String: Version]?
        do {
            selectedVersions = try dao.loadSelectedVersions()
        } catch {
            XCTFail()
        }
        
        let loadedDao = VersionUserDefaultDAO()
        
        var selectedVersionsLoaded: [String: Version]?
        do {
            selectedVersionsLoaded = try loadedDao.loadSelectedVersions()
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(selectedVersions?.keys.count, selectedVersionsLoaded?.keys.count)
        XCTAssertEqual(selectedVersions?[testName]?.name, selectedVersionsLoaded?[testName]?.name)
        XCTAssertEqual(selectedVersions?[testName]?.probability, selectedVersionsLoaded?[testName]?.probability)
    }
}

// MARK: - Extension

extension VersionUserDefaultDAOTest: GollumUserDefaultHelper {}

