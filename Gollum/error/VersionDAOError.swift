//
//  VersionDAOError.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

enum VersionDAOError: Error {
    case versionNameValueNotFound(String)
    case versionProbabilityValueNotFound(String)
}
