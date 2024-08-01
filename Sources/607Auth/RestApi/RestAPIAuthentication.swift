//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
import Combine

class RestAPIAuthService: AuthService {
    func sendEmailVerification() -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    func deleteUser() -> AnyPublisher<Void, any Error> {
        fatalError()
    }
    
    private let apiClient: APIClient
    
    init(config: APIConfig) {
        self.apiClient = APIClient(config: config)
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
        return apiClient.signIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error> {
        return apiClient.signUp(email: email, password: password, name: name)
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        return apiClient.signOut()
    }
    
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        return apiClient.getCurrentUser()
    }
}


// MARK: - Internal Auth Implementations



private class APIClient {
    init(config: APIConfig) {
        // Initialize API client with config
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
        // Implement REST API sign in
        fatalError("Not implemented")
    }
    
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error> {
        // Implement REST API sign up
        fatalError("Not implemented")
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        // Implement REST API sign out
        fatalError("Not implemented")
    }
    
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        // Implement get current user from REST API
        fatalError("Not implemented")
    }
}

