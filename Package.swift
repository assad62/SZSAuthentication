// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SixZeroSevenAuth",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "SixZeroSevenAuth",
            targets: ["SixZeroSevenAuth"]),
    ],
    dependencies: [
        .package(url: "https://github.com/supabase-community/supabase-swift.git", from: "0.2.1"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "10.0.0")
    ],
    targets: [
        .target(
            name: "SixZeroSevenAuth",
            dependencies: [
                .product(name: "Supabase", package: "supabase-swift"),
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]),
        .testTarget(
            name: "SixZeroSevenAuthTests",
            dependencies: ["SixZeroSevenAuth"]),
    ]
)
