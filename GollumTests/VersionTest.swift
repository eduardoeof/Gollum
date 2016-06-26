//
//  VersionTest.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import XCTest

@testable import Gollum

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

    func testInitWithValue() {
        version = try! Version(value: "A:0.2")
        
        XCTAssertEqual(version.name, "A")
        XCTAssertEqual(version.probability, 0.2)
    }
    
    func testEqualableOperator() {
        let version2 = Version(stringLiteral: "A:0.5")
        
        XCTAssert(version == version2)
    }
    
    func testInitWithoutProbabilityValue() {
        do {
            version = try Version(value: "A")
        } catch GollumError.VersionSyntaxError(let message) {
            XCTAssertEqual(message, "ABTest case expression must have name and probability values splitted by : (e.g. \"MyTestCaseA:0.5\")")
        } catch {
            XCTFail()
        }
    }
    
    func testInitWithoutNameValue() {
        do {
            version = try Version(value: "0.5")
        } catch GollumError.VersionSyntaxError(let message) {
            XCTAssertEqual(message, "ABTest case expression must have name and probability values splitted by : (e.g. \"MyTestCaseA:0.5\")")
        } catch {
            XCTFail()
        }
    }
    
    func testInitWithProbabilityNotFloatValue() {
        do {
            version = try Version(value: "A:A")
        } catch GollumError.VersionSyntaxError(let message) {
            XCTAssertEqual(message, "ABTest must have a probablity (e.g. 0.5)")
        } catch {
            XCTFail()
        }
    }
}