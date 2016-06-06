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
        let text = String(self.subjectType)
        let regex = try! NSRegularExpression(pattern: "([a-zA-Z0-9]+)", options: [])
        let matches = regex.matchesInString(text, options: [], range: NSRange(location: 0, length: text.characters.count))
        
        return (text as NSString).substringWithRange(matches[0].range)
    }
}
