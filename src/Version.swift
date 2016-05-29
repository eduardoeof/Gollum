//
//  Version.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

public struct Version {
    let name: String
    let probability: Float
}

// MARK: - Extension Equatable

extension Version: Equatable {}

public func ==(lhs: Version, rhs: Version) -> Bool {
    return lhs.name == rhs.name && lhs.probability == rhs.probability
}

// MARK: - Extension StringLiteralConvertible

extension Version: StringLiteralConvertible {
    public typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    public typealias UnicodeScalarLiteralType = StringLiteralType
    
    public init(unicodeScalarLiteral value: UnicodeScalarLiteralType) {
        self.init(value: value)!
    }
    
    public init(extendedGraphemeClusterLiteral value: ExtendedGraphemeClusterLiteralType) {
        self.init(value: value)!
    }
    
    public init(stringLiteral value: StringLiteralType) {
        self.init(value: value)!
    }
    
    // MARK: - Private
    
    private init?(value: String) {
        let fields = Version.extractFieldsFrom(value)
        
        if fields.count != 2 {
            assertionFailure("Syntax error: ABTest case expression must have name and probability values splitted by : (e.g. \"MyTestCaseA:0.5\")")
            return nil
        }
        
        let name = fields[0]
        
        guard let probability = Float(fields[1]) else {
            assertionFailure("Syntax error: ABTest must have a probablity (e.g. 0.5)")
            return nil
        }
        
        self.name = name
        self.probability = probability
    }
    
    // MARK: - Static private
    
    static private func extractFieldsFrom(value: String) -> [String] {
        return value.characters.split { $0 == ":" }.map(String.init)
    }
}
