//
//  Mirror+Helper.swift
//  Gollum
//
//  Created by eduardo.ferreira on 5/30/16.
//  Copyright © 2016 eduardoeof. All rights reserved.
//

import Foundation

extension Mirror {
    var subjectName: String {
        let text = String(describing: self.subjectType)
        let regex = try! NSRegularExpression(pattern: "([a-zA-Z0-9]+)", options: [])
        let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
        
        return (text as NSString).substring(with: matches[0].range)
    }
}
