//
//  VersionDAOProtocol.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/1/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

protocol VersionDAOProtocol {
    func saveSelectedVersion(_ version: Version, testName name: String)
    func didSelectVersionForTest(_ name: String) -> Bool
    func loadSelectedVersions() throws -> [String: Version]
}
