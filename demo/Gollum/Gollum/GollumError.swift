//
//  GollumError.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/30/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

enum GollumError: ErrorType {
    case ProbabilitySumIncorrect(String)
    case TestNotFound(String)
}
