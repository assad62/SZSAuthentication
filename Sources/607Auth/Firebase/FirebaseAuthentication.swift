//
//  File.swift
//  
//
//  Created by Development on 1/8/2024.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import Combine

class FirebaseAuthenticationService:AuthService{
   
    private let auth: Auth
    
    init(config: FirebaseConfig) {
            guard let googleAppID = config.plistContent["GOOGLE_APP_ID"] as? String,
                  let gcmSenderID = config.plistContent["GCM_SENDER_ID"] as? String else {
                fatalError("Invalid plist content: GOOGLE_APP_ID or GCM_SENDER_ID missing")
            }
            
            let options = FirebaseOptions(googleAppID: googleAppID, gcmSenderID: gcmSenderID)
            
            if let apiKey = config.plistContent["API_KEY"] as? String {
                options.apiKey = apiKey
            }
            if let projectID = config.plistContent["PROJECT_ID"] as? String {
                options.projectID = projectID
            }
            if let bundleID = config.plistContent["BUNDLE_ID"] as? String {
                options.bundleID = bundleID
            }
            if let clientID = config.plistContent["CLIENT_ID"] as? String {
                options.clientID = clientID
            }
            if let databaseURL = config.plistContent["DATABASE_URL"] as? String {
                options.databaseURL = databaseURL
            }
            if let storageBucket = config.plistContent["STORAGE_BUCKET"] as? String {
                options.storageBucket = storageBucket
            }
            
            if FirebaseApp.app() == nil {
                FirebaseApp.configure(options: options)
            }
            
            self.auth = Auth.auth()
        }
    
    func signIn(email: String, password: String) -> AnyPublisher<SZSUser, Error> {
      
        
        return Future { [weak self] promise in
            self?.auth.signIn(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let authResult = authResult {
                    let user = SZSUser(id: authResult.user.uid, email: authResult.user.email ?? "", name: authResult.user.displayName)
                    promise(.success(user))
                } else {
                    promise(.failure(NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signUp(email: String, password: String, name: String?) -> AnyPublisher<SZSUser, Error> {
        return Future { [weak self] promise in
            self?.auth.createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    promise(.failure(error))
                } else if let authResult = authResult {
                    let changeRequest = authResult.user.createProfileChangeRequest()
                    changeRequest.displayName = name
                    changeRequest.commitChanges { error in
                        if let error = error {
                            promise(.failure(error))
                        } else {
                            let user = SZSUser(id: authResult.user.uid, email: authResult.user.email ?? "", name: name)
                            promise(.success(user))
                        }
                    }
                } else {
                    promise(.failure(NSError(domain: "FirebaseAuth", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"])))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func signOut() -> AnyPublisher<Void, Error> {
        return Future { [weak self] promise in
            do {
                try self?.auth.signOut()
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    func getCurrentUser() -> AnyPublisher<SZSUser?, Never> {
        return Future { [weak self] promise in
            if let currentUser = self?.auth.currentUser {
                let user = SZSUser(id: currentUser.uid, email: currentUser.email ?? "", name: currentUser.displayName)
                promise(.success(user))
            } else {
                promise(.success(nil))
            }
        }.eraseToAnyPublisher()
    }
    
    
    func sendEmailVerification() -> AnyPublisher<Void, Error> {
            return Future { promise in
                guard let user = Auth.auth().currentUser else {
                    promise(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in"])))
                    return
                }
                
                user.sendEmailVerification { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            }.eraseToAnyPublisher()
    }
    
    func deleteUser() -> AnyPublisher<Void, Error> {
            return Future { promise in
                guard let user = Auth.auth().currentUser else {
                    promise(.failure(NSError(domain: "FirebaseAuthService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No user is currently signed in"])))
                    return
                }
                
                user.delete { error in
                    if let error = error {
                        promise(.failure(error))
                    } else {
                        promise(.success(()))
                    }
                }
            }.eraseToAnyPublisher()
        }
    
    
}



