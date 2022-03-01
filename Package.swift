// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mediator",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "Mediator",
            targets: ["Mediator"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/square/Valet", from: "4.1.2"),
        .package(url: "git@github.com:My-DIGI-ID/id-wallet-2-ios-aries-sdk.git",
                 branch: "development")
    ],
    targets: [
        .target(
            name: "Mediator",
            dependencies: ["Valet",
                           .product(name: "Aries", package: "id-wallet-2-ios-aries-sdk")]
        ),
        .testTarget(
            name: "MediatorTests",
            dependencies: ["Mediator"],
            resources: [.copy("Resource")]
        )
    ]
)
