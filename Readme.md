# [DEPRECATED] SZSAuthManager

⚠️ **DEPRECATION NOTICE** ⚠️
This package is no longer maintained and will not receive further updates.
Please use the new provider-specific packages instead:
- For Firebase: [SZSFirebaseAuth]TODO
- For Supabase: [SZSSupabaseAuth]TODO
- For RestAPI:  [SZSRestAuth]TODO

Reason:
SZSAuthManager is being deprecated to focus on provider-specific authentication solutions, allowing
for deeper integration with each provider's unique features. This approach simplifies maintenance,
reduces complexity, and enables more efficient updates tailored to individual authentication
services.

---

# SZSAuthManager

SZSAuthManager is a flexible authentication management system for Swift applications. It supports multiple authentication providers and offers a unified interface for common authentication operations.

## Features

- Support for multiple authentication providers (Firebase, REST API, Supabase)
- Unified interface for authentication operations
- Built-in user model (SZSUser)
- Combine-based asynchronous operations
- Easy to extend with new authentication providers

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/assad62/SZSAuthManager.git", from: "1.0.0")
]
```

## Usage

### Initializing SZSAuthManager

Use the Builder pattern to create an instance of SZSAuthManager:

```swift
import SZSAuth

func readGoogleServiceInfo() -> [String: Any]? {
    guard let plistPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"),
          let plistContent = NSDictionary(contentsOfFile: plistPath) as? [String: Any] else {
        print("Failed to read GoogleService-Info.plist")
        return nil
    }
    return plistContent
}

let firebaseConfig = FirebaseConfig(plistContent: readGoogleServiceInfo()!)
let authManager = SZSAuthManager.Builder(authProvider: .firebase)
    .setFirebaseConfig(firebaseConfig)
    .build()
```

### Authentication Operations

#### Sign In

```swift
authManager.signIn(email: "user@example.com", password: "password")
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("Sign in completed")
        case .failure(let error):
            print("Sign in failed: \(error)")
        }
    }, receiveValue: { user in
        print("Signed in user: \(user)")
    })
    .store(in: &cancellables)
```

#### Sign Up

```swift
authManager.signUp(email: "newuser@example.com", password: "password", name: "New User")
    .sink(receiveCompletion: { completion in
        // Handle completion
    }, receiveValue: { user in
        print("Signed up user: \(user)")
    })
    .store(in: &cancellables)
```

#### Sign Out

```swift
authManager.signOut()
    .sink(receiveCompletion: { completion in
        // Handle completion
    }, receiveValue: {
        print("User signed out")
    })
    .store(in: &cancellables)
```

#### Get Current User

```swift
authManager.getCurrentUser()
    .sink(receiveValue: { user in
        if let user = user {
            print("Current user: \(user)")
        } else {
            print("No user is currently signed in")
        }
    })
    .store(in: &cancellables)
```

#### Send Verification Email

```swift
authManager.sendVerificationEmail()
    .sink(receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("Verification email sent successfully")
        case .failure(let error):
            print("Failed to send verification email: \(error)")
        }
    }, receiveValue: { _ in })
    .store(in: &cancellables)
```


#### Delete User

```swift
authManager.deleteUser()
    .sink(receiveCompletion: { completion in
        // Handle completion
    }, receiveValue: {
        print("User account deleted")
    })
    .store(in: &cancellables)
```

## Use Cases

SZSAuthManager is particularly useful in the following scenarios:

1. **Multi-platform Applications**: Provides a consistent authentication interface across iOS, macOS, and tvOS.

2. **White-Label Applications**: Easily switch between auth providers for different branded versions of your app.

3. **Transitioning Between Auth Providers**: Gradually migrate from one auth system to another.

4. **Applications with Multiple Auth Methods**: Abstract away differences between various authentication methods.

5. **Testing and Development**: Create mock authentication services for testing or local development.

## Supported Authentication Providers

- Firebase
- REST API
- Supabase

To use a different provider, change the `authProvider` parameter when creating the SZSAuthManager and provide the appropriate configuration.

## Custom Authentication Providers

To add a custom authentication provider:

1. Create a new case in the `AuthProvider` enum.
2. Implement a new `AuthService` conforming to the `AuthService` protocol.
3. Add a new configuration type if needed.
4. Update the `SZSAuthManager.Builder` to handle the new provider.

## License

[Add your license information here]

## Support

[Add support information, such as how to report issues or where to ask questions]
