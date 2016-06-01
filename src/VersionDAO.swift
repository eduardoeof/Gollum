//
//  VersionDAO.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/1/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

struct VersionDAO: VersionDAOProtocol {
    func saveSelectedVersion(version: Version, testName name: String) {
        let adapter = VersionAdapter(version: version)
        NSUserDefaults.standardUserDefaults().setObject(adapter, forKey: name)
    }
}

// MARK: - Adapter

private class VersionAdapter: NSObject {
    let version: Version
    
    init(version: Version) {
        self.version = version
    }
}
