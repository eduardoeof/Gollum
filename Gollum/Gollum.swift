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
    
    private let versionDAO: VersionDAOProtocol
    
    private typealias TestName = String
    private var tests = [TestName: [Version]]()
    private var selectedVersions: [TestName: Version]
    
    // MARK: - Init
    
    init(versionDAO: VersionDAOProtocol) {
        self.versionDAO = versionDAO
        self.selectedVersions = try! versionDAO.loadSelectedVersions()
    }
    
    convenience init() {
        self.init(versionDAO: VersionUserDefaultDAO())
    }
    
    // MARK: - Public
    
    public func registerVersions<T: RawRepresentable where T.RawValue == Version>(versions: [T]) throws {
        guard let firstVersion = versions.first else {
            throw GollumError.EmptyVersionArrayPassed("A empty version array was passed to registered.")
        }
        
        let testName = extractTestName(firstVersion)
        
        for version in versions {
            registerVersion(version: version.rawValue, testName: testName)
        }

        if selectedVersions[testName] == nil {
            try raffleVersion(testName: testName)
            
            guard let selectedVersions = selectedVersions[testName] else {
                throw GollumError.SelectedVersionNotFound("Test \(testName) should have a selected version.")
            }
            
            versionDAO.saveSelectedVersion(selectedVersions, testName: testName)
        }
    }
    
    public func getSelectedVersion<T: RawRepresentable where T.RawValue == Version>(test: T.Type) throws -> T {
        let testName = String(test)
        
        guard let rawValue = selectedVersions[testName],
            let version = test.init(rawValue: rawValue) else {
                throw GollumError.SelectedVersionNotFound("Test \(testName) should have a selected version.")
        }
        
        return version
    }
    
    public func isVersionSelected<T: RawRepresentable where T.RawValue == Version>(version: T) throws-> Bool {
        let testName = extractTestName(version)
        
        guard let selectedVersion = selectedVersions[testName] else {
            throw GollumError.SelectedVersionNotFound("Test \(testName) should have a selected version.")
        }
        
        return selectedVersion == version.rawValue
    }
    
    // MARK: - Private
    
    private func extractTestName<T: RawRepresentable where T.RawValue == Version>(versionType: T) -> String {
        let mirror = Mirror(reflecting: versionType)
        return mirror.subjectName
    }
    
    private func registerVersion(version version: Version, testName name: String) {
        if tests[name] != nil {
            tests[name]?.append(version)
        } else {
            tests[name] = [version]
        }
    }
    
    private func raffleVersion(testName name: String) throws {
        guard let versions = tests[name] where isTestProbabilitySumValid(versions) else {
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
