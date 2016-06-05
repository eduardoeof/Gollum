//
//  GollumError.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/30/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

public enum GollumError: ErrorType {
    case VersionSyntaxError(String)
    case ProbabilitySumIncorrect(String)
    case EmptyVersionArrayPassed(String)
    case SelectedVersionNotFound(String)
}
