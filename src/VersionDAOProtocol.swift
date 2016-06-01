//
//  VersionDAOProtocol.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/1/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

protocol VersionDAOProtocol {
    func saveSelectedVersion(version: Version, testName name: String)
}
