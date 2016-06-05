//
//  VersionDAOUserDefault.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

class VersionUserDefaultDAO: VersionDAOProtocol {
    private static let storageName = "GollumSelectedTests"
    
    private typealias TestName = String
    private typealias SelectedVersion = [String: Float]
    private typealias Tests = [TestName: SelectedVersion]
    private var tests: Tests
    
    // MARK: Init
    
    init() {
        if let selectedTests = VersionUserDefaultDAO.loadSelectedTests() {
            self.tests = selectedTests
        } else {
            self.tests = Tests()
        }
    }
    
    // MARK: - VersionDAOProtocol
    
    func saveSelectedVersion(version: Version, testName name: String) {
        let selectedVersion = convertToSelectedVersion(version)
        tests[name] = selectedVersion
        
        saveSelectedTests()
    }
    
    func didSelectVersionForTest(name: String) -> Bool {
        return tests[name] != nil
    }
    
    func loadSelectedVersions() throws -> [String: Version] {
        var selectedVersions = [String: Version]()
        
        for (testName, selectedVersion) in tests {
            let version = try convertToVersion(selectedVersion)
            selectedVersions[testName] = version
        }
        
        return selectedVersions
    }
    
    // MARK: - Private Static
    
    private static func loadSelectedTests() -> Tests? {
        return NSUserDefaults.standardUserDefaults().objectForKey(VersionUserDefaultDAO.storageName) as? Tests
    }
    
    // MARK: - Private
    
    private func saveSelectedTests() {
        NSUserDefaults.standardUserDefaults().setObject(tests, forKey: VersionUserDefaultDAO.storageName)
    }
    
    private func convertToSelectedVersion(version: Version) -> SelectedVersion {
        return [version.name: version.probability]
    }
    
    private func convertToVersion(selectedVersion: SelectedVersion) throws -> Version {
        guard let name = selectedVersion.keys.first else {
            throw VersionDAOError.VersionNameValueMissing("Selected version's name is missing")
        }
        
        guard let probability = selectedVersion[name] else {
            throw VersionDAOError.VersionProbabilityValueMissing("Selected version's probability is missing")
        }

        return Version(name: name, probability: probability)
    }
}
