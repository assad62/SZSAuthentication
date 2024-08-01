//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
public struct SupabaseConfig {
    let projectURL: URL
    let apiKey: String
    
    public init(projectURL: URL, apiKey: String) {
        self.projectURL = projectURL
        self.apiKey = apiKey
    }
}
