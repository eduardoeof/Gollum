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
        
        do {
            switch try Gollum.instance.getSelectedVersion(MyAdorableABTest) {
            case .A:
                view.backgroundColor = UIColor.redColor()
            case .B:
                view.backgroundColor = UIColor.greenColor()
            }
        } catch let error {
            print(error)
        }
    }
    
}
