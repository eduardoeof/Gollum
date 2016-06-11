//
//  GollumTests.swift
//  GollumTests
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import XCTest

class GollumTests: XCTestCase {
    var gollum: Gollum!
    
    override func setUp() {
        super.setUp()
        gollum = Gollum()
    }
    
    override func tearDown() {
        removeSelectedTestsFromStorage()
    }
    
    //MARK: - Test cases
    
    func testInstanceProperty() {
        XCTAssertNotNil(Gollum.instance)
        XCTAssert(Gollum.instance === Gollum.instance)
    }
    
    func testRegisterVersions() {
        do {
            try gollum.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
            
            let isA = try gollum.isVersionSelected(GollumABTest.A)
            let isB = try gollum.isVersionSelected(GollumABTest.B)
            let isC = try gollum.isVersionSelected(GollumABTest.C)
            XCTAssert(isA || isB || isC)
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsWithVersionsAlreadySelected() {
        do {
            try gollum.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
            
            let gollum2 = Gollum()
            try gollum2.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
            
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.A), try gollum2.isVersionSelected(GollumABTest.A))
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.B), try gollum2.isVersionSelected(GollumABTest.B))
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.C), try gollum2.isVersionSelected(GollumABTest.C))
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsEmptyVersionArrayPassed() {
        do {
            let versions = [GollumABTest]()
            try gollum.registerVersions(versions)
        } catch GollumError.EmptyVersionArrayPassed(let message) {
            XCTAssertEqual(message, "A empty version array was passed to registered.")
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsProbabilitySumIncorrect() {
        do {
            try gollum.registerVersions([GollumABTestProbabilitySumIncorrect.A, GollumABTestProbabilitySumIncorrect.B])
        } catch GollumError.ProbabilitySumIncorrect(let message) {
            XCTAssertEqual(message, "Sum of GollumABTestProbabilitySumIncorrect's probability isn't 1.0")
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedAlwaysA() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysAVersion.A,
                GollumABTestAlwaysAVersion.B,
                GollumABTestAlwaysAVersion.C])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.A))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.B))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.C))
        } catch {
            XCTFail()
        }
    }

    func testIsVersionSelectedAlwaysB() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysBVersion.A,
                GollumABTestAlwaysBVersion.B,
                GollumABTestAlwaysBVersion.C])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.B))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.A))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.C))
        } catch {
            XCTFail()
        }
    }

    func testIsVersionSelectedAlwaysC() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysCVersion.A,
                GollumABTestAlwaysCVersion.B,
                GollumABTestAlwaysCVersion.C])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.C))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.A))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.B))
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedErrorSelectedVersionNotFound() {
        do {
            try gollum.isVersionSelected(GollumABTest.A)
        } catch GollumError.SelectedVersionNotFound(let message) {
            XCTAssertEqual(message, "Test GollumABTest should have a selected version.")
        } catch {
            XCTFail()
        }
    }
    
    func testLoadSelectedVersionsFromStorage() {
        do {
            try gollum.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
            
            let gollumStorage = Gollum()
            
            let isA = try gollumStorage.isVersionSelected(GollumABTest.A)
            let isB = try gollumStorage.isVersionSelected(GollumABTest.B)
            let isC = try gollumStorage.isVersionSelected(GollumABTest.C)
            XCTAssert(isA || isB || isC)
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionA() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysAVersion.A,
                GollumABTestAlwaysAVersion.B,
                GollumABTestAlwaysAVersion.C])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysAVersion) {
            case .A:
                XCTAssertTrue(true)
            case .B:
                XCTFail()
            case .C:
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionB() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysBVersion.A,
                GollumABTestAlwaysBVersion.B,
                GollumABTestAlwaysBVersion.C])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysBVersion) {
            case .A:
                XCTFail()
            case .B:
                XCTAssertTrue(true)
            case .C:
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionC() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysCVersion.A,
                GollumABTestAlwaysCVersion.B,
                GollumABTestAlwaysCVersion.C])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysCVersion) {
            case .A:
                XCTFail()
            case .B:
                XCTFail()
            case .C:
                XCTAssertTrue(true)
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionErrorSelectedVersionNotFound() {
        do {
            try gollum.getSelectedVersion(GollumABTestAlwaysAVersion)
        } catch GollumError.SelectedVersionNotFound(let message) {
            XCTAssertEqual(message, "Test GollumABTestAlwaysAVersion should have a selected version.")
        } catch {
            XCTFail()
        }
    }
}

// MARK: - Extension

extension GollumTests: GollumUserDefaultHelper {}

// MARK: - Test enum

private enum GollumABTest: Version {
    case A = "A:0.3"
    case B = "B:0.3"
    case C = "C:0.4"
}

enum GollumABTestAlwaysAVersion: Version {
    case A = "A:1.0"
    case B = "B:0.0"
    case C = "C:0.0"
}

enum GollumABTestAlwaysBVersion: Version {
    case A = "A:0.0"
    case B = "B:1.0"
    case C = "C:0.0"
}

enum GollumABTestAlwaysCVersion: Version {
    case A = "A:0.0"
    case B = "B:0.0"
    case C = "C:1.0"
}

private enum GollumABTestProbabilitySumIncorrect: Version {
    case A = "A:0.3"
    case B = "B:0.3"
}
