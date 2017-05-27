//
//  GollumError.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/30/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

public enum GollumError: Error {
    case versionSyntaxError(String)
    case probabilitySumIncorrect(String)
    case emptyVersionArrayPassed(String)
    case selectedVersionNotFound(String)
}
