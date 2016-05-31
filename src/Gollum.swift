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
    
    public func isVersionSelected<T: RawRepresentable where T.RawValue == Version>(versionType: T) throws -> Bool {
        let name = extractTestName(versionType)
        
        if selectedVersions[name] == nil {
            try raffleVersion(testName: name)
        }
        
        return selectedVersions[name] == versionType.rawValue
    }
    
    // MARK: - Private
    
    private func extractTestName<T: RawRepresentable where T.RawValue == Version>(versionType: T) -> String {
        let mirror = Mirror(reflecting: versionType)
        return mirror.subjectName
    }
    
    private func insertVersion(version version: Version, testName name: String) {
        if tests[name] != nil {
            tests[name]?.append(version)
        } else {
            tests[name] = [version]
        }
    }
    
    private func raffleVersion(testName name: String) throws {
        guard let versions = tests[name] else {
            throw GollumError.TestNotFound("Test \(name) wasn't registered.")
        }
        
        guard isTestProbabilitySumValid(versions) else {
            throw GollumError.ProbabilitySumIncorrect("Sum of \(name)'s probability isn't 1.0")
        }

        var selectedNumber = generateAleatoryNumber()
        let probabilities = versions.map { Int($0.probability * 1000) }
        for (index, probability) in probabilities.enumerate() {
            if selectedNumber <= probability {
                selectedVersions[name] = versions[index]
                return
            }
            
            selectedNumber -= probability
        }
    }
    
    private func isTestProbabilitySumValid(versions: [Version]) -> Bool {
        return versions.reduce(0) { $0 + $1.probability } == 1.0
    }
    
    private func generateAleatoryNumber() -> Int {
        return Int(arc4random_uniform(1000) + 1)
    }
}
