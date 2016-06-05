//
//  VersionDAOUserDefault.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

class VersionDAOUserDefault: VersionDAOProtocol {
    private static let storageName = "GollumSelectedTests"
    
    private typealias SelectedVersion = [String: Float]
    private typealias SelectedTests = [String: SelectedVersion]
    private var selectedTests: SelectedTests
    
    // MARK: Init
    
    init() {
        if let selectedTests = VersionDAOUserDefault.loadSelectedTests() {
            self.selectedTests = selectedTests
        } else {
            self.selectedTests = SelectedTests()
        }
    }
    
    // MARK: - Internal
    
    func saveSelectedVersion(version: Version, testName name: String) {
        let selectedVersion = convertToSelectedVersion(version)
        selectedTests[name] = selectedVersion
        
        saveSelectedTests()
    }
    
    // MARK: - Private Static
    
    private static func loadSelectedTests() -> SelectedTests? {
        return NSUserDefaults.standardUserDefaults().objectForKey(VersionDAOUserDefault.storageName) as? SelectedTests
    }
    
    // MARK: - Private
    
    private func saveSelectedTests() {
        NSUserDefaults.standardUserDefaults().setObject(selectedTests, forKey: VersionDAOUserDefault.storageName)
    }
    
    private func convertToSelectedVersion(version: Version) -> SelectedVersion {
        return [version.name: version.probability]
    }
}