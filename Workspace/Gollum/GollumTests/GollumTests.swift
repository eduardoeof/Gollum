//
//  GollumTests.swift
//  GollumTests
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import XCTest

@testable import Gollum

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
            try gollum.registerVersions([GollumABTest.a, GollumABTest.b, GollumABTest.c])
            
            let isA = try gollum.isVersionSelected(GollumABTest.a)
            let isB = try gollum.isVersionSelected(GollumABTest.b)
            let isC = try gollum.isVersionSelected(GollumABTest.c)
            XCTAssert(isA || isB || isC)
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsWithVersionsAlreadySelected() {
        do {
            try gollum.registerVersions([GollumABTest.a, GollumABTest.b, GollumABTest.c])
            
            let gollum2 = Gollum()
            try gollum2.registerVersions([GollumABTest.a, GollumABTest.b, GollumABTest.c])
            
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.a), try gollum2.isVersionSelected(GollumABTest.a))
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.b), try gollum2.isVersionSelected(GollumABTest.b))
            XCTAssertEqual(try gollum.isVersionSelected(GollumABTest.c), try gollum2.isVersionSelected(GollumABTest.c))
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsEmptyVersionArrayPassed() {
        do {
            let versions = [GollumABTest]()
            try gollum.registerVersions(versions)
        } catch GollumError.emptyVersionArrayPassed(let message) {
            XCTAssertEqual(message, "A empty version array was passed to registered.")
        } catch {
            XCTFail()
        }
    }
    
    func testRegisterVersionsProbabilitySumIncorrect() {
        do {
            try gollum.registerVersions([GollumABTestProbabilitySumIncorrect.a, GollumABTestProbabilitySumIncorrect.b])
        } catch GollumError.probabilitySumIncorrect(let message) {
            XCTAssertEqual(message, "Sum of GollumABTestProbabilitySumIncorrect's probability isn't 1.0")
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedAlwaysA() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysAVersion.a,
                                         GollumABTestAlwaysAVersion.b,
                                         GollumABTestAlwaysAVersion.c])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.a))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.b))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysAVersion.c))
        } catch {
            XCTFail()
        }
    }

    func testIsVersionSelectedAlwaysB() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysBVersion.a,
                                         GollumABTestAlwaysBVersion.b,
                                         GollumABTestAlwaysBVersion.c])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.b))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.a))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysBVersion.c))
        } catch {
            XCTFail()
        }
    }

    func testIsVersionSelectedAlwaysC() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysCVersion.a,
                GollumABTestAlwaysCVersion.b,
                GollumABTestAlwaysCVersion.c])
            
            XCTAssertTrue(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.c))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.a))
            XCTAssertFalse(try gollum.isVersionSelected(GollumABTestAlwaysCVersion.b))
        } catch {
            XCTFail()
        }
    }
    
    func testIsVersionSelectedErrorSelectedVersionNotFound() {
        do {
            _ = try gollum.isVersionSelected(GollumABTest.a)
        } catch GollumError.selectedVersionNotFound(let message) {
            XCTAssertEqual(message, "Test GollumABTest should have a selected version.")
        } catch {
            XCTFail()
        }
    }
    
    func testLoadSelectedVersionsFromStorage() {
        do {
            try gollum.registerVersions([GollumABTest.a, GollumABTest.b, GollumABTest.c])
            
            let gollumStorage = Gollum()
            
            let isA = try gollumStorage.isVersionSelected(GollumABTest.a)
            let isB = try gollumStorage.isVersionSelected(GollumABTest.b)
            let isC = try gollumStorage.isVersionSelected(GollumABTest.c)
            XCTAssert(isA || isB || isC)
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionA() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysAVersion.a,
                                         GollumABTestAlwaysAVersion.b,
                                         GollumABTestAlwaysAVersion.c])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysAVersion.self) {
            case .a:
                XCTAssertTrue(true)
            case .b:
                XCTFail()
            case .c:
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionB() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysBVersion.a,
                                         GollumABTestAlwaysBVersion.b,
                                         GollumABTestAlwaysBVersion.c])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysBVersion.self) {
            case .a:
                XCTFail()
            case .b:
                XCTAssertTrue(true)
            case .c:
                XCTFail()
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionAlwayVersionC() {
        do {
            try gollum.registerVersions([GollumABTestAlwaysCVersion.a,
                                         GollumABTestAlwaysCVersion.b,
                                         GollumABTestAlwaysCVersion.c])
            
            switch try gollum.getSelectedVersion(GollumABTestAlwaysCVersion.self) {
            case .a:
                XCTFail()
            case .b:
                XCTFail()
            case .c:
                XCTAssertTrue(true)
            }
        } catch {
            XCTFail()
        }
    }
    
    func testGetSelectedVersionErrorSelectedVersionNotFound() {
        do {
            _ = try gollum.getSelectedVersion(GollumABTestAlwaysAVersion.self)
        } catch GollumError.selectedVersionNotFound(let message) {
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
    case a = "A:0.3"
    case b = "B:0.3"
    case c = "C:0.4"
}

private enum GollumABTestAlwaysAVersion: Version {
    case a = "A:1.0"
    case b = "B:0.0"
    case c = "C:0.0"
}

private enum GollumABTestAlwaysBVersion: Version {
    case a = "A:0.0"
    case b = "B:1.0"
    case c = "C:0.0"
}

private enum GollumABTestAlwaysCVersion: Version {
    case a = "A:0.0"
    case b = "B:0.0"
    case c = "C:1.0"
}

private enum GollumABTestProbabilitySumIncorrect: Version {
    case a = "A:0.3"
    case b = "B:0.3"
}
