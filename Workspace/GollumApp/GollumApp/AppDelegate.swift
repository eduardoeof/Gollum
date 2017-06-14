//
//  AppDelegate.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        try! Gollum.instance.registerVersions([MyABTest.b, MyABTest.b])
        
        return true
    }
}

