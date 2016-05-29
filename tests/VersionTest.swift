//
//  VersionTest.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import XCTest

class VersionTest: XCTestCase {
    var version: Version!
    
    override func setUp() {
        super.setUp()
        
        version = Version(stringLiteral: "A:0.5")
    }

    //MARK: - Test cases
    
    func testInitWithStringLiteralTypeValue() {
        XCTAssertEqual(version.name, "A")
        XCTAssertEqual(version.probability, 0.5)
    }

    func testInitWithExtendedGraphemeClusterLiteralTypeValue() {
        version = Version(extendedGraphemeClusterLiteral: "A:0.4")
        
        XCTAssertEqual(version.name, "A")
        XCTAssertEqual(version.probability, 0.4)
    }
    
    func testInitWithUnicodeScalarLiteralTypeValue() {
        version = Version(unicodeScalarLiteral: "A:0.3")
        
        XCTAssertEqual(version.name, "A")
        XCTAssertEqual(version.probability, 0.3)
    }
    
    func testEqualableOperator() {
        let version2 = Version(stringLiteral: "A:0.5")
        
        XCTAssert(version == version2)
    }
    
//    func testInitWithoutProbabilityValue() {
//        version = Version(stringLiteral: "A")
//    }
//    
//    func testInitWithoutNameValue() {
//        version = Version(stringLiteral: "0.5")
//    }
//    
//    func testInitWithProbabilityNotFloatValue() {
//        version = Version(stringLiteral: "A:A")
//    }
}