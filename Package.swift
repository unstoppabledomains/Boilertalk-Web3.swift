// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Boilertalk-Web3",
    platforms: [
       .iOS(.v13),
       .macOS(.v10_15),
       .watchOS(.v6),
       .tvOS(.v13),
       .macCatalyst(.v14),
       .driverKit(.v20),
    ],
    products: [
        .library(
            name: "Boilertalk-Web3",
            targets: ["Boilertalk-Web3"]),
        .library(
            name: "Web3PromiseKit",
            targets: ["Web3PromiseKit"]),
        .library(
            name: "Web3ContractABI",
            targets: ["Web3ContractABI"]),
    ],
    dependencies: [
        // Core dependencies
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.3.0"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.6.0"),
        .package(name: "secp256k1", url: "https://github.com/Boilertalk/secp256k1.swift.git", from: "0.1.7"),
        .package(url: "https://github.com/apple/swift-collections.git", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/vapor/websocket-kit", .upToNextMajor(from: "2.6.1")),

        // PromiseKit dependency
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "6.18.1"),

        // Test dependencies
        .package(url: "https://github.com/Quick/Quick.git", from: "5.0.1"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "10.0.0"),
    ],
    targets: [
        .target(
            name: "Boilertalk-Web3",
            dependencies: [
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "secp256k1", package: "secp256k1"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "WebSocketKit", package: "websocket-kit"),
            ],
            path: "Sources",
            sources: ["Core", "FoundationHTTP"]),
        .target(
            name: "Web3PromiseKit",
            dependencies: [
                .target(name: "Boilertalk-Web3"),
                .target(name: "Web3ContractABI"),
                .product(name: "PromiseKit", package: "PromiseKit"),
            ],
            path: "Sources",
            sources: ["PromiseKit"]),
        .target(
            name: "Web3ContractABI",
            dependencies: [
                .target(name: "Boilertalk-Web3"),
                .product(name: "BigInt", package: "BigInt"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
            ],
            path: "Sources",
            sources: ["ContractABI"]),
        .testTarget(
            name: "Web3Tests",
            dependencies: [
                .target(name: "Boilertalk-Web3"),
                .target(name: "Web3PromiseKit"),
                .target(name: "Web3ContractABI"),
                .product(name: "Quick", package: "Quick"),
                .product(name: "Nimble", package: "Nimble"),
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
