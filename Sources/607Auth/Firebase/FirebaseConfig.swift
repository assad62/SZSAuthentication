//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
public struct FirebaseConfig {
    let plistContent: [String: Any]
    
    public init(plistContent: [String: Any]) {
        self.plistContent = plistContent
    }
}
