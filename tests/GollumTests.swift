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
        
        XCTAssert(gollum.isVersionSelected(GollumABTest.A) ||
            gollum.isVersionSelected(GollumABTest.B) ||
            gollum.isVersionSelected(GollumABTest.C))
    }
    
    func testIsVersionSelectedAlwaysA() {
        gollum.registerVersion(GollumABTestAlwaysAVersion.A)
        gollum.registerVersion(GollumABTestAlwaysAVersion.B)
        gollum.registerVersion(GollumABTestAlwaysAVersion.C)
        
        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysAVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysAVersion.B))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysAVersion.C))
    }
    
    func testIsVersionSelectedAlwaysB() {
        gollum.registerVersion(GollumABTestAlwaysBVersion.A)
        gollum.registerVersion(GollumABTestAlwaysBVersion.B)
        gollum.registerVersion(GollumABTestAlwaysBVersion.C)
        
        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysBVersion.B))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysBVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysBVersion.C))
    }
    
    func testIsVersionSelectedAlwaysC() {
        gollum.registerVersion(GollumABTestAlwaysCVersion.A)
        gollum.registerVersion(GollumABTestAlwaysCVersion.B)
        gollum.registerVersion(GollumABTestAlwaysCVersion.C)
        
        XCTAssertTrue(gollum.isVersionSelected(GollumABTestAlwaysCVersion.C))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysCVersion.A))
        XCTAssertFalse(gollum.isVersionSelected(GollumABTestAlwaysCVersion.B))
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