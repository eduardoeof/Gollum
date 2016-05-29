//
//  Gollum.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/29/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

public class Gollum {
    static public let instance = Gollum()
    
    private typealias TestName = String
    private var tests = [TestName: [Version]]()
    private var selectedVersions = [TestName: Version]()
    
    // MARK: - Public
    
    public func registerVersion<T: RawRepresentable where T.RawValue == Version>(versionType: T) {
        let testName = extractTestName(versionType)
        
        insertVersion(version: versionType.rawValue, testName: testName)
    }
    
    public func isVersionSelected<T: RawRepresentable where T.RawValue == Version>(versionType: T) {
        let testName = extractTestName(versionType)
        
        // Check if raffle happened
        
        // If not, do it!
        
        // If yes, get selected version
    }
    
    // MARK: - Private
    
    private func extractTestName<T: RawRepresentable where T.RawValue == Version>(versionType: T) -> String {
        let mirror = Mirror(reflecting: versionType)
        return "\(mirror.subjectType)"
    }
    
    private func insertVersion(version version: Version, testName name: String) {
        if tests[name] != nil {
            tests[name]?.append(version)
        } else {
            tests[name] = [version]
        }
    }
}