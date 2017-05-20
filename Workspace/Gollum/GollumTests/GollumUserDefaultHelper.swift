//
//  GollumUserDefaultHelper.swift
//  Gollum
//
//  Created by eduardo.ferreira on 6/5/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation
import XCTest

@testable import Gollum

let gollumStorageName = "GollumSelectedTests"

protocol GollumUserDefaultHelper {
    associatedtype SelectedVersion = [String: Float]
    associatedtype SelectedTests = [String: SelectedVersion]
}

extension GollumUserDefaultHelper where Self: XCTestCase {
    func loadSelectedTests() -> SelectedTests? {
        return UserDefaults.standard.object(forKey: gollumStorageName) as? SelectedTests
    }
    
    func removeSelectedTestsFromStorage() {
        UserDefaults.standard.removeObject(forKey: gollumStorageName)
    }
}
