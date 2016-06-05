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
        } catch {
            XCTFail()
        }
        
        let isA = gollum.isVersionSelected(GollumABTest.A)
        let isB = gollum.isVersionSelected(GollumABTest.B)
        let isC = gollum.isVersionSelected(GollumABTest.C)
        XCTAssert(isA || isB || isC)
    }
    
    func testRegisterVersionsWithVersionsAlreadySelected() {
        do {
            try gollum.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
        } catch {
            XCTFail()
        }
        
        let gollum2 = Gollum()
        
        do {
            try gollum2.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
        } catch {
            XCTFail()
        }
        
        XCTAssertEqual(gollum.isVersionSelected(GollumABTest.A), gollum2.isVersionSelected(GollumABTest.A))
        XCTAssertEqual(gollum.isVersionSelected(GollumABTest.B), gollum2.isVersionSelected(GollumABTest.B))
        XCTAssertEqual(gollum.isVersionSelected(GollumABTest.C), gollum2.isVersionSelected(GollumABTest.C))
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
        } catch {
            XCTFail()
        }
        
        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysAVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysAVersion.B))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysAVersion.C))
    }

    func testIsVersionSelectedAlwaysB() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysBVersion.A,
                GollumABTestAlwaysBVersion.B,
                GollumABTestAlwaysBVersion.C])
        } catch {
            XCTFail()
        }

        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysBVersion.B))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysBVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysBVersion.C))
    }

    func testIsVersionSelectedAlwaysC() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysCVersion.A,
                GollumABTestAlwaysCVersion.B,
                GollumABTestAlwaysCVersion.C])
        } catch {
            XCTFail()
        }
        
        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysCVersion.C))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysCVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysCVersion.B))
    }
    
    func testIsVersionSelectedWithNoTestRegistered() {
        XCTAssertFalse(gollum.isVersionSelected(GollumABTest.A))
    }
    
    func testLoadSelectedVersionsFromStorage() {
        do {
            try gollum.registerVersions([GollumABTest.A, GollumABTest.B, GollumABTest.C])
        } catch {
            XCTFail()
        }
        
        let gollumStorage = Gollum()
        
        let isA = gollumStorage.isVersionSelected(GollumABTest.A)
        let isB = gollumStorage.isVersionSelected(GollumABTest.B)
        let isC = gollumStorage.isVersionSelected(GollumABTest.C)
        XCTAssert(isA || isB || isC)
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

private enum GollumABTestAlwaysAVersion: Version {
    case A = "A:1.0"
    case B = "B:0.0"
    case C = "C:0.0"
}

private enum GollumABTestAlwaysBVersion: Version {
    case A = "A:0.0"
    case B = "B:1.0"
    case C = "C:0.0"
}

private enum GollumABTestAlwaysCVersion: Version {
    case A = "A:0.0"
    case B = "B:0.0"
    case C = "C:1.0"
}

private enum GollumABTestProbabilitySumIncorrect: Version {
    case A = "A:0.3"
    case B = "B:0.3"
}
