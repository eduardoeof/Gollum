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
    
    //MARK: - Test cases
    
    func testInstanceProperty() {
        XCTAssertNotNil(Gollum.instance)
        XCTAssert(Gollum.instance === Gollum.instance)
    }
    
    func testIsVersionSelected() {
        gollum.registerVersion(GollumABTest.A)
        gollum.registerVersion(GollumABTest.B)
        gollum.registerVersion(GollumABTest.C)
        
        do {
            let isA = try gollum.isVersionSelected(GollumABTest.A)
            let isB = try gollum.isVersionSelected(GollumABTest.B)
            let isC = try gollum.isVersionSelected(GollumABTest.C)
            XCTAssert(isA || isB || isC)
        } catch {
            XCTFail()
        }
    }

    func testIsVersionSelectedTestNotFound() {
        do {
            try gollum.isVersionSelected(GollumABTest.A)
        } catch GollumError.TestNotFound(let message) {
            XCTAssertEqual(message, "Test GollumABTest wasn't registered.")
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedTestProbabilitySumIncorrect() {
        gollum.registerVersion(GollumABTestProbabilitySumIncorrect.A)
        gollum.registerVersion(GollumABTestProbabilitySumIncorrect.B)
        
        do {
            try gollum.isVersionSelected(GollumABTestProbabilitySumIncorrect.A)
        } catch GollumError.ProbabilitySumIncorrect(let message) {
            XCTAssertEqual(message, "Sum of GollumABTestProbabilitySumIncorrect's probability isn't 1.0")
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedAlwaysA() {
        gollum.registerVersion(GollumABTestAlwaysAVersion.A)
        gollum.registerVersion(GollumABTestAlwaysAVersion.B)
        gollum.registerVersion(GollumABTestAlwaysAVersion.C)
        
        XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.A))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.B))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.C))
    }

    func testIsVersionSelectedAlwaysB() {
        gollum.registerVersion(GollumABTestAlwaysBVersion.A)
        gollum.registerVersion(GollumABTestAlwaysBVersion.B)
        gollum.registerVersion(GollumABTestAlwaysBVersion.C)

        XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.B))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.A))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.C))
    }

    func testIsVersionSelectedAlwaysC() {
        gollum.registerVersion(GollumABTestAlwaysCVersion.A)
        gollum.registerVersion(GollumABTestAlwaysCVersion.B)
        gollum.registerVersion(GollumABTestAlwaysCVersion.C)
        
        XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.C))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.A))
        XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.B))
    }
}

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
