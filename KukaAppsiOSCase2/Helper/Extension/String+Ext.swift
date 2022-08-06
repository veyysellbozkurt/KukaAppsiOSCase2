//
//  String+Ext.swift
//  KukaAppsiOSCase2
//
//  Created by Veysel Bozkurt on 5.08.2022.
//

import Foundation


extension String {
    var configuredForAPICall: String {
        let str = self.components(separatedBy: "\'")        
        let t = str.joined(separator: "'")
        return t.replacingOccurrences(of: " ", with: "%20")
    }
}
