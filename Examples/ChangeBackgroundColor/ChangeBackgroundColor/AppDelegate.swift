//
//  AppDelegate.swift
//  ChangeBackgroundColor
//
//  Created by eduardo.ferreira on 6/6/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import UIKit
import Gollum

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        try! Gollum.instance.registerVersions([MyAdorableABTest.A, MyAdorableABTest.B])
        
        return true
    }
}

