//
//  ViewController.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/28/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check seleted version
        
        do {
            switch try Gollum.instance.getSelectedVersion(MyABTest.self) {
            case .a:
                view.backgroundColor = UIColor.red
            case .b:
                view.backgroundColor = UIColor.green
            }
        } catch let error {
            print(error)
        }
        
        // Or
           
        do {
            if try Gollum.instance.isVersionSelected(MyABTest.a) {
                view.backgroundColor = UIColor.red
            } else if try Gollum.instance.isVersionSelected(MyABTest.b) {
                view.backgroundColor = UIColor.green
            }
        } catch let error {
            print(error)
        }
    }
}
