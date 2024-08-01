//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
import Combine

public enum AuthProvider {
    case firebase
    case restAPI
    case supabase
}


public protocol AuthService {
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error>
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error>
    func signOut() -> AnyPublisher<Void, Error>
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never>
    func sendEmailVerification() -> AnyPublisher<Void, Error>
    func deleteUser() -> AnyPublisher<Void, Error>
}



public class SZSAuthManager {
    private let authService: AuthService
    
    private init(authService: AuthService) {
        self.authService = authService
    }
    
    public func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
        return authService.signIn(email: email, password: password)
    }
    
    public func signUp(email: String, password: String, name: String? = nil) -> AnyPublisher<SZSUser, Error> {
        return authService.signUp(email: email, password: password, name: name)
    }
    
    public func signOut() -> AnyPublisher<Void, Error> {
        return authService.signOut()
    }
    
    public func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        return authService.getCurrentUser()
    }
    
    public func deleteUser() -> AnyPublisher<Void,Error>{
        return authService.deleteUser()
    }
    // MARK: - Builder
    
    public class Builder {
        private var authProvider: AuthProvider
        private var firebaseConfig: FirebaseConfig?
        private var apiConfig: APIConfig?
        private var supabaseConfig: SupabaseConfig?
        
        public init(authProvider: AuthProvider) {
            self.authProvider = authProvider
        }
        
        public func setFirebaseConfig(_ config: FirebaseConfig) -> Builder {
            self.firebaseConfig = config
            return self
        }
        
        public func setAPIConfig(_ config: APIConfig) -> Builder {
            self.apiConfig = config
            return self
        }
        
        public func setSupabaseConfig(_ config: SupabaseConfig) -> Builder {
            self.supabaseConfig = config
            return self
        }
        
        public func build() -> SZSAuthManager {
            let authService: AuthService
            
            switch authProvider {
            case .firebase:
                guard let config = firebaseConfig else {
                    fatalError("Firebase config is required for Firebase auth provider")
                }
                authService = FirebaseAuthenticationService(config: config)
            case .restAPI:
                guard let config = apiConfig else {
                    fatalError("API config is required for REST API auth provider")
                }
                authService = RestAPIAuthService(config: config)
            case .supabase:
                guard let config = supabaseConfig else {
                    fatalError("Supabase config is required for Supabase auth provider")
                }
                authService = SupabaseAuthService(config: config)
            }
            
            return SZSAuthManager(authService: authService)
        }
    }
}

