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
    
    public func registerVersions<T: RawRepresentable>(_ versions: [T]) throws where T.RawValue == Version {
        guard let firstVersion = versions.first else {
            throw GollumError.emptyVersionArrayPassed("A empty version array was passed to registered.")
        }
        
        let testName = extractTestName(from: firstVersion)

        if selectedVersions[testName] == nil {
            try raffleVersion(versions, testName: testName)
            
            guard let selectedVersions = selectedVersions[testName] else {
                throw GollumError.selectedVersionNotFound("Test \(testName) should have a selected version.")
            }
            
            versionDAO.saveSelectedVersion(selectedVersions, testName: testName)
        }
    }
    
    public func getSelectedVersion<T: RawRepresentable>(_ testType: T.Type) throws -> T where T.RawValue == Version {
        let testName = extractTestName(from: testType)
        
        guard let rawValue = selectedVersions[testName],
            let version = testType.init(rawValue: rawValue) else {
                throw GollumError.selectedVersionNotFound("Test \(testName) should have a selected version.")
        }
        
        return version
    }
    
    public func isVersionSelected<T: RawRepresentable>(_ version: T) throws -> Bool where T.RawValue == Version {
        let testName = extractTestName(from: version)
        
        guard let selectedVersion = selectedVersions[testName] else {
            throw GollumError.selectedVersionNotFound("Test \(testName) should have a selected version.")
        }
        
        return selectedVersion == version.rawValue
    }
    
    // MARK: - Private
    
    private func extractTestName<T: RawRepresentable>(from versionType: T) -> String where T.RawValue == Version {
        let mirror = Mirror(reflecting: versionType)
        return mirror.subjectName
    }

    private func extractTestName<T: RawRepresentable>(from testType: T.Type) -> String {
        let mirror = Mirror(reflecting: testType)
        return mirror.subjectName
    }
    
    private func raffleVersion<T: RawRepresentable>(_ versions: [T], testName: String) throws where T.RawValue == Version {
        let versionsRawValue = convertToArrayOfRawValue(versions)
        
        guard isVersionsProbabilitySumValid(versionsRawValue) else {
            throw GollumError.probabilitySumIncorrect("Sum of \(testName)'s probability isn't 1.0")
        }

        var selectedNumber = generateAleatoryNumber()
        let probabilities = versionsRawValue.map { Int($0.probability * 1000) }
        for (index, probability) in probabilities.enumerated() {
            if selectedNumber <= probability {
                selectedVersions[testName] = versionsRawValue[index]
                return
            }
            
            selectedNumber -= probability
        }
    }
    
    private func isVersionsProbabilitySumValid(_ versions: [Version]) -> Bool {
        return versions.reduce(0) { $0 + $1.probability } == 1.0
    }
    
    private func generateAleatoryNumber() -> Int {
        return Int(arc4random_uniform(1000) + 1)
    }
    
    private func convertToArrayOfRawValue<T: RawRepresentable>(_ versions: [T]) -> [T.RawValue] where T.RawValue == Version {
        var rawValues: [T.RawValue] = []
        for version in versions {
            rawValues.append(version.rawValue)
        }
        
        return rawValues
    }
}
