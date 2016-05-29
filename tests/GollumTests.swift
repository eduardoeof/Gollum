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
    
//    func testRegisterVersion() {
//        gollum.registerVersion(GollumABTestMock.A)
//        gollum.registerVersion(GollumABTestMock.B)
//        
//        
//    }
}

// MARK: - Test enum

private enum GollumABTestMock: Version {
    case A = "A:0.5"
    case B = "B:0.5"
}
