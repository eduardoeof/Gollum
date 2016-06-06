//
//  ViewController.swift
//  ChangeBackgroundColor
//
//  Created by eduardo.ferreira on 6/6/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import UIKit
import Gollum

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
