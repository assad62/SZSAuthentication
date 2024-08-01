//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation

public struct SZSUser: Codable, Equatable {
    public let id: String
    public let email: String
    public let name: String?
    public let isEmailVerified: Bool
    
    public init(id: String, email: String, name: String? = nil, isEmailVerified: Bool = false) {
        self.id = id
        self.email = email
        self.name = name
        self.isEmailVerified = isEmailVerified
    }
}
