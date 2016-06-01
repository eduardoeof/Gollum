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
        
        if Gollum.instance.isVersionSelected(MyAdorableABTest.A) {
            view.backgroundColor = UIColor.redColor()
        } else if Gollum.instance.isVersionSelected(MyAdorableABTest.B) {
            view.backgroundColor = UIColor.greenColor()
        }
    }
    
}
