//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
public struct APIConfig {
    let baseURL: URL
    let apiKey: String
    
    public init(baseURL: URL, apiKey: String) {
        self.baseURL = baseURL
        self.apiKey = apiKey
    }
}
