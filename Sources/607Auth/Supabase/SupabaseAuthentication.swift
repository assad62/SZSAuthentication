//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
import Combine

private class SupabaseClient {
    init(config: SupabaseConfig) {
        // Initialize Supabase client with config
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
        // Implement Supabase sign in
        fatalError("Not implemented")
    }
    
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error> {
        // Implement Supabase sign up
        fatalError("Not implemented")
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        // Implement Supabase sign out
        fatalError("Not implemented")
    }
    
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        // Implement get current user from Supabase
        fatalError("Not implemented")
    }
}


class SupabaseAuthService: AuthService {
    func sendEmailVerification() -> AnyPublisher<Void, any Error> {
        fatalError("Not implemented")
    }
    
    func deleteUser() -> AnyPublisher<Void, any Error> {
        fatalError("Not implemented")
    }
    
    private let supabaseClient: SupabaseClient
    
    init(config: SupabaseConfig) {
        self.supabaseClient = SupabaseClient(config: config)
    }
    
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
        return supabaseClient.signIn(email: email, password: password)
    }
    
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error> {
        return supabaseClient.signUp(email: email, password: password, name: name)
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        return supabaseClient.signOut()
    }
    
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        return supabaseClient.getCurrentUser()
    }
}
