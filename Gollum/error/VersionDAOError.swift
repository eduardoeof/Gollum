//
//  VersionDAOError.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

enum VersionDAOError: ErrorType {
    case VersionNameValueNotFound(String)
    case VersionProbabilityValueNotFound(String)
}
